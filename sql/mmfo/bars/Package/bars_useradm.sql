
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_useradm.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_USERADM 
is

    -------------------------------------------------------
    --                                                   --
    --  Пакет процедур и функций для администрирования   --
    --             пользователей комплекса               --
    --                                                   --
    -------------------------------------------------------


    -------------------------------------------------------
    -- Константы                                         --
    -------------------------------------------------------

    VERSION_HEADER       constant varchar2(64)  := 'version 1.10 16.05.2012';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';

    -- состояние учетной записи
    USER_STATE_ACTIVE    constant number        :=  1;
    USER_STATE_DELETED   constant number        :=  0;

    -- состояние изменений
    USER_APPROVED        constant number        :=  1;
    USER_NOTAPPROVED     constant number        :=  0;

    -- признак ответ. исполнителя
    USER_ACCOWN          constant number        :=  1;
    USER_NOTACCOWN       constant number        :=  0;

    -- признак активности
    USER_ENABLED         constant number        :=  0;
    USER_DISABLED        constant number        :=  1;

    -------------------------------------------------------
    -- Типы                                              --
    -------------------------------------------------------

    type t_varchar2list is table of varchar2(2000);
    type t_numberlist   is table of number;


    /* Должно совпадать с типом поля CHGTYPE всех таблиц очередей */
    subtype t_resource_id       is  sec_resources.res_id%type;
    subtype t_resource_chgtype  is  number(1);

    subtype t_user_id           is  staff$base.id%type;


    /* Тип, описывающий абстрактный столбец строки */
    type t_anycol  is record(
                        column_name   varchar2(30),
                        column_type   varchar2(30),
                        column_size   number(10),
                        column_data   sys.anydata );

    /* Тип, описывающий абстрактную строку */
    type t_anyrow  is table of t_anycol;



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



    --------------------------------------------------------
    --                                                    --
    -- Процедуры для работы с профилями пользователей     --
    --                                                    --
    --------------------------------------------------------

    --------------------------------------------------------
    -- CREATE_PROFILE()
    --
    --     Процедура создания пользовательского профиля
    --
    --     Параметры:
    --
    --      p_profile        Имя профиля
    --
    --      p_pwdexpiretime  Срок действия пароля
    --
    --      p_pwdgracetime   Кол-во дней до напоминания
    --                       о смене пароля
    --
    --      p_pwdreusetime   Кол-во паролей, после которого
    --                       разрешено использ. текущего
    --
    --      p_pwdverifyfunc  Функция проверки сложности
    --                       пароля
    --
    --      p_pwdlocktime    Время блокировки уч. записи
    --
    --      p_usrmaxlogin    Макс. кол-во неудачных
    --                       попыток входа
    --
    --      p_usrmaxsession  Макс. кол-во сессий польз.
    --
    procedure create_profile(
        p_profile       in  staff_profiles.profile%type,
        p_pwdexpiretime in  staff_profiles.pwd_expire_time%type    default null,
        p_pwdgracetime  in  staff_profiles.pwd_grace_time%type     default null,
        p_pwdreusemax   in  staff_profiles.pwd_reuse_max%type      default null,
        p_pwdreusetime  in  staff_profiles.pwd_reuse_time%type     default null,
        p_pwdverifyfunc in  staff_profiles.pwd_verify_func%type    default null,
        p_pwdlocktime   in  staff_profiles.pwd_lock_time%type      default null,
        p_usrmaxlogin   in  staff_profiles.user_max_login%type     default null,
        p_usrmaxsession in  staff_profiles.user_max_session%type   default null );


    --------------------------------------------------------
    -- ALTER_PROFILE()
    --
    --     Процедура изменения пользовательского профиля
    --
    --     Параметры:
    --
    --      p_profile        Имя профиля
    --
    --      p_pwdexpiretime  Срок действия пароля
    --
    --      p_pwdgracetime   Кол-во дней до напоминания
    --                       о смене пароля
    --
    --      p_pwdreusetime   Кол-во паролей, после которого
    --                       разрешено использ. текущего
    --
    --      p_pwdverifyfunc  Функция проверки сложности
    --                       пароля
    --
    --      p_pwdlocktime    Время блокировки уч. записи
    --
    --      p_usrmaxlogin    Макс. кол-во неудачных
    --                       попыток входа
    --
    --      p_usrmaxsession  Макс. кол-во сессий польз.
    --
    procedure alter_profile(
        p_profile    in  staff_profiles.profile%type,
        p_pwdexpiretime in  staff_profiles.pwd_expire_time%type,
        p_pwdgracetime  in  staff_profiles.pwd_grace_time%type,
        p_pwdreusemax   in  staff_profiles.pwd_reuse_max%type,
        p_pwdreusetime  in  staff_profiles.pwd_reuse_time%type,
        p_pwdverifyfunc in  staff_profiles.pwd_verify_func%type,
        p_pwdlocktime   in  staff_profiles.pwd_lock_time%type,
        p_usrmaxlogin   in  staff_profiles.user_max_login%type,
        p_usrmaxsession in  staff_profiles.user_max_session%type );


    --------------------------------------------------------
    -- DROP_PROFILE()
    --
    --     Процедура удаления пользовательского профиля
    --
    --     Параметры:
    --
    --      p_profile        Имя профиля
    --
    procedure drop_profile(
        p_profile    in  staff_profiles.profile%type);


    --------------------------------------------------------
    --                                                    --
    -- Процедуры для работы с пользователями комплекса    --
    --                                                    --
    --------------------------------------------------------

    -----------------------------------------------------------------
    -- CREATE_USER()
    --
    --     Процедура создания пользователя комплекса
    --
    --     Параметры:
    --
    --      p_usrfio          ФИО пользователя
    --
    --      p_usrtabn         Табельный номер
    --
    --      p_usrtype         Тип пользователя
    --
    --      p_usraccown       Признак ответ. исполнителя
    --
    --      p_usrbranch       Код отделения
    --
    --      p_usrusearc       Признак доступности арх. схемы
    --
    --      p_usrusegtw       Признак использование шлюза
    --
    --      p_usrwprof        Имя веб-профиля
    --
    --      p_reclogname      Имя учетной записи БД
    --
    --      p_recpasswd       Пароль пользователя
    --
    --      p_recappauth      Имя пользователя для proxy
    --                        аутентификации
    --
    --      p_recprof         Имя профиля
    --
    --      p_recdefrole      Имя умолчательной роли
    --
    --      p_recrsgrp        Имя ресурсной группы
    --
    --      p_usrid
    --
    --      p_gtwpasswd
    --
    --      p_canselectbranch Возможность представляться отделением
    --
    --      p_chgpwd          Признак необходимости смены пароля пользователем
    --
    --      p_tipid           Код типового пользователя
    --
    procedure create_user(
        p_usrfio      in  staff$base.fio%type,
        p_usrtabn     in  staff$base.tabn%type,
        p_usrtype     in  staff$base.clsid%type,
        p_usraccown   in  staff$base.type%type,
        p_usrbranch   in  varchar2,
        p_usrusearc   in  staff$base.usearc%type,
        p_usrusegtw   in  staff$base.usegtw%type,
        p_usrwprof    in  staff$base.web_profile%type,
        p_reclogname  in  staff$base.logname%type,
        p_recpasswd   in  varchar2,
        p_recappauth  in  varchar2,
        p_recprof     in  varchar2,
        p_recdefrole  in  varchar2,
        p_recrsgrp    in  varchar2,
        p_usrid       in  staff$base.id%type default null,
        p_gtwpasswd   in  varchar2           default null,
        p_canselectbranch in staff$base.can_select_branch%type default null,
        p_chgpwd      in  char               default null,
        p_tipid       in  number             default null );


    -----------------------------------------------------------------
    -- ALTER_USER()
    --
    --     Процедура обновление параметров пользователя
    --
    --     Параметры:
    --
    --      p_usrid           Ид. пользователя
    --
    --      p_usrfio          ФИО пользователя
    --
    --      p_usrtabn         Табельный номер
    --
    --      p_usrtype         Тип пользователя
    --
    --      p_usraccown       Признак ответ. исполнителя
    --
    --      p_usrbranch       Код отделения
    --
    --      p_usrusearc       Признак доступности арх. схемы
    --
    --      p_usrusegtw       Признак использование шлюза
    --
    --      p_usrwprof        Имя веб-профиля
    --
    --      p_recpasswd       Пароль пользователя
    --
    --      p_recappauth      Имя пользователя для proxy
    --                        аутентификации
    --
    --      p_recprof         Имя профиля
    --
    --      p_recdefrole      Имя умолчательной роли
    --
    --      p_recrsgrp        Имя ресурсной группы
    --
    --      p_canselectbranch Возможность представляться отделением
    --
    --      p_chgpwd          Признак необходимости смены пароля пользователем
    --
    --      p_tipid           Код типового пользователя
    --
    procedure alter_user(
        p_usrid       in  staff$base.id%type,
        p_usrfio      in  staff$base.fio%type,
        p_usrtabn     in  staff$base.tabn%type,
        p_usrtype     in  staff$base.clsid%type,
        p_usraccown   in  staff$base.type%type,
        p_usrbranch   in  varchar2,
        p_usrusearc   in  staff$base.usearc%type,
        p_usrusegtw   in  staff$base.usegtw%type,
        p_usrwprof    in  staff$base.web_profile%type,
        p_recpasswd   in  varchar2,
        p_recappauth  in  varchar2,
        p_recprof     in  varchar2,
        p_recdefrole  in  varchar2,
        p_recrsgrp    in  varchar2,
        p_canselectbranch in staff$base.can_select_branch%type default null,
        p_chgpwd      in  char               default null,
        p_tipid       in  number             default null );


    -----------------------------------------------------------------
    -- DROP_USER()
    --
    --     Процедура для удаления пользователя комплекса
    --
    --     Параметры:
    --
    --      p_userid   Ид. пользователя
    --
    procedure drop_user(
        p_userid    in  staff$base.id%type );


    -----------------------------------------------------------------
    -- DROP_USER_novalidate()
    --
    --     Процедура для удаления пользователя комплекса (novalidate)
    --
    --     Параметры:
    --
    --      p_userid   Ид. пользователя
    --
    procedure drop_user_novalidate(
        p_userid    in  staff$base.id%type );


    --------------------------------------------------------
    -- CLONE_USER()
    --
    --     Процедура для клонирования пользователей
    --
    --
    --
    procedure clone_user(
        p_srcUserId  in  staff$base.id%type,
        p_dstUserId  in  staff$base.id%type,
        p_reslist    in  t_numberlist,
        p_resclone   in  t_numberlist,
        p_resclean   in  t_numberlist      );


    -----------------------------------------------------------------
    -- RECREATE_USER()
    --
    --     Процедура пересоздания пользователя комплекса
    --
    --
    --
    --
    procedure recreate_user(
                  p_usrid       in  staff$base.id%type,
                  p_recpasswd   in  varchar2,
                  p_recappauth  in  varchar2,
                  p_recprof     in  varchar2,
                  p_recdefrole  in  varchar2,
                  p_recrsgrp    in  varchar2   );


    -----------------------------------------------------------------
    -- LOCK_USER()
    --
    --     Процедура блокировки пользователя
    --
    --     Параметры:
    --
    --      p_userid       Идентификатор пользователя
    --
    --      p_begindate    Начальная дата блокировки
    --
    --      p_enddate      Конечная дата блокировки
    --
    procedure lock_user(
        p_userid    in  staff$base.id%type,
        p_begindate in  staff$base.rdate1%type default null,
        p_enddate   in  staff$base.rdate2%type default null );


    -----------------------------------------------------------------
    -- UNLOCK_USER()
    --
    --     Процедура разблокировки пользователя
    --
    --     Параметры:
    --
    --      p_userid       Идентификатор пользователя
    --
    --      p_begindate    Начальная дата разблокировки
    --
    --      p_enddate      Конечная дата разблокировки
    --
    procedure unlock_user(
        p_userid    in  staff$base.id%type,
        p_begindate in  staff$base.adate1%type default null,
        p_enddate   in  staff$base.adate2%type default null );


    -----------------------------------------------------------------
    -- TRANSMIT_USER_ACCOUNTS()
    --
    --     Процедура передачи счетов пользователя другому
    --     пользователю
    --
    --     Параметры:
    --
    --      p_olduserid   Ид. пользователя, счета кот. передаются
    --
    --      p_newuserid   Ид. пользователя, кому передаются
    --
    procedure transmit_user_accounts(
        p_olduserid    in  staff$base.id%type,
        p_newuserid    in  staff$base.id%type );


    --------------------------------------------------------
    -- ADD_USER_MBRANCH()
    --
    --     Разрешение пользователю работать с указанным
    --     псевдо-МФО
    --
    --     Параметры:
    --
    --         p_userid       Идентификатор пользователя
    --
    --         p_mfo          Псевдо-МФО
    --
    procedure add_user_mbranch(
        p_userid    in  staff$base.id%type,
        p_mfo       in  banks.mfo%type     );


    --------------------------------------------------------
    -- REMOVE_USER_MBRANCH()
    --
    --     Запрет пользователю работать с указанным
    --     псевдо-МФО
    --
    --     Параметры:
    --
    --         p_userid       Идентификатор пользователя
    --
    --         p_mfo          Псевдо-МФО
    --
    procedure remove_user_mbranch(
        p_userid    in  staff$base.id%type,
        p_mfo       in  banks.mfo%type     );


    --------------------------------------------------------
    -- GET_USER_LICSTATE()
    --
    --     Функция получения состояния лицензии учетной
    --     записи пользователя
    --
    --     Параметры:
    --
    --      p_userid   Ид. пользователя
    --
    function get_user_licstate(
       p_userid    in  staff$base.id%type ) return number;


    -----------------------------------------------------------------
    -- SET_USER_CONTEXT()
    --
    --     Процедура установки контекста для просмотра ресурсов
    --     указанного пользователя
    --
    --     Параметры:
    --
    --      p_userid    Ид. пользователя
    --
    procedure set_user_context(
        p_userid  in  staff$base.id%type);

    -----------------------------------------------------------------
    -- SET_USER_MODE()
    --
    --     Процедура установки режима работы с пользователями
    --
    --     Параметры:
    --
    --      p_mode      Код режима
    --
    procedure set_user_mode(
        p_mode    in  number );


    -----------------------------------------------------------------
    -- SET_USER_MODEPARAM()
    --
    --     Процедура установки параметров текущего режима
    --
    --     Параметры:
    --
    --      p_mpname     Код параметра
    --
    --      p_mpvalue    Значение параметра
    --
    procedure set_user_modeparam(
        p_mpname    in  varchar2,
        p_mpvalue   in  varchar2 );



    --------------------------------------------------------
    -- GET_LAST_MESSAGE()
    --
    --     Функция получения сообщения функции
    --
    --
    function get_last_message return varchar2;


    -----------------------------------------------------------------
    -- CHECK_RESOURCE_CONDITION()
    --
    --     Функция проверки условия активизации ресурса
    --
    --     Параметры:
    --
    --         p_condition  Условие
    --
    --
    function check_resource_condition(
                  p_condition    in  varchar2) return varchar2;


    -----------------------------------------------------------------
    -- GRANT_USER_RESOURCE()
    --
    --     Процедура выдачи ресурса пользователю
    --
    --     Параметры:
    --
    --         p_userid    Ид. пользователя
    --
    --         p_resid     Ид. ресурса
    --
    --         p_colnames  Список имен реквизитов
    --
    --         p_colvals   Список значений реквизитов
    --
    --
    procedure grant_user_resource(
                  p_userid   in  staff$base.id%type,
                  p_resid    in  sec_resources.res_id%type,
                  p_colnames in  t_varchar2list,
                  p_colvals  in  t_varchar2list             );


    -----------------------------------------------------------------
    -- REVOKE_USER_RESOURCE()
    --
    --     Процедура отзыва ресурса у пользователя
    --
    --     Параметры:
    --
    --         p_userid    Ид. пользователя
    --
    --         p_resid     Ид. ресурса
    --
    --         p_colnames  Список имен реквизитов
    --
    --         p_colvals   Список значений реквизитов
    --
    --
    procedure revoke_user_resource(
                  p_userid   in  staff$base.id%type,
                  p_resid    in  sec_resources.res_id%type,
                  p_colnames in  t_varchar2list,
                  p_colvals  in  t_varchar2list             );


    -----------------------------------------------------------------
    -- ALTER_USER_RESOURCE()
    --
    --     Процедура изменения параметров ресурса у пользователя
    --
    --     Параметры:
    --
    --         p_userid     Ид. пользователя
    --
    --         p_resid      Ид. ресурса
    --
    --         p_pkcolnames Список имен столбцов перв. ключа
    --
    --         p_pkcolvals  Список значений столбцов перв. ключа
    --
    --         p_colnames   Список имен изменяемых реквизитов
    --
    --         p_colvals    Список значений изменяемых реквизитов
    --
    --
    procedure alter_user_resource(
                  p_userid     in  staff$base.id%type,
                  p_resid      in  sec_resources.res_id%type,
                  p_pkcolnames in  t_varchar2list,
                  p_pkcolvals  in  t_varchar2list,
                  p_colnames   in  t_varchar2list,
                  p_colvals    in  t_varchar2list             );


    -----------------------------------------------------------------
    -- GRANT_USER_ATTRIBUTE()
    --
    --     Процедура выдачи для подтверждения атрибутов пользователя
    --
    --     Параметры:
    --
    --         p_userid     Ид. пользователя
    --
    --         p_attrnames  Список имен атрибутов
    --
    --         p_attrvals   Список значений атрибутов
    --
    --
    procedure grant_user_attribute(
                  p_userid    in  staff$base.id%type,
                  p_attrnames in  t_varchar2list,
                  p_attrvals  in  t_varchar2list             );


    -----------------------------------------------------------------
    -- ALTER_USER_ATTRIBUTE()
    --
    --     Процедура подтверждения изменения атрибутов пользователя
    --
    --     Параметры:
    --
    --         p_userid     Ид. пользователя
    --
    --         p_attrid     Ид. атрибута
    --
    --
    procedure alter_user_attribute(
                  p_userid  in  staff$base.id%type,
                  p_attrid  in  sec_attributes.attr_id%type  );


    -----------------------------------------------------------------
    -- DROP_USER_ATTRIBUTE()
    --
    --     Процедура удаления атрибута пользователя
    --
    --     Параметры:
    --
    --         p_userid     Ид. пользователя
    --
    --         p_attrid     Ид. атрибута
    --
    --
    procedure drop_user_attribute(
                  p_userid  in  staff$base.id%type,
                  p_attrid  in  sec_attributes.attr_id%type  );


    -----------------------------------------------------------------
    -- CHANGE_USER_PRIVS()
    --
    --     Процедура выдачи/отзыва привилегий пользователя в
    --     в зависимости от выданных ему ресурсов
    --
    --     Параметры:
    --
    --         p_userid     Ид. пользователя
    --
    procedure change_user_privs(
                  p_userid     in  staff$base.id%type );


    -----------------------------------------------------------------
    -- Procedure   : set_app_context
    -- Description : Процедура установки контекста для просмотра ресурсов
    --               указанного АРМа
    -- Params:
    --   p_codeapp - код АРМа
    --
    procedure set_app_context (p_codeapp applist.codeapp%type);


    -----------------------------------------------------------------
    -- Procedure   : create_app
    -- Description : Процедура создания АРМа
    -- Params:
    --   p_appid    - код АРМа
    --   p_appname  - наименование АРМа
    --   p_frontend - код фронтального интерфейса
    --
    procedure create_app (
      p_appid      applist.codeapp%type,
      p_appname    applist.name%type,
      p_frontend   applist.frontend%type );


    -----------------------------------------------------------------
    -- Procedure   : alter_app
    -- Description : Процедура обновления АРМа
    -- Params:
    --   p_appid    - код АРМа
    --   p_appname  - наименование АРМа
    --   p_frontend - код фронтального интерфейса
    --
    procedure alter_app (
      p_appid      applist.codeapp%type,
      p_appname    applist.name%type,
      p_frontend   applist.frontend%type );


    -----------------------------------------------------------------
    -- Procedure   : drop_app
    -- Description : Процедура удаления АРМа
    -- Params:
    --   p_appid - код АРМа
    --
    procedure drop_app ( p_appid applist.codeapp%type );


    -----------------------------------------------------------------
    -- Procedure   : grant_app_resource
    -- Description : Процедура выдачи ресурса АРМу
    -- Params:
    --   p_appid    - код АРМа
    --   p_resid    - код ресурса
    --   p_colnames - список имен реквизитов
    --   p_colvals  - список значений реквизитов
    --
    procedure grant_app_resource (
      p_appid    in  applist.codeapp%type,
      p_resid    in  sec_resources.res_id%type,
      p_colnames in  t_varchar2list,
      p_colvals  in  t_varchar2list );


    -----------------------------------------------------------------
    -- Procedure   : revoke_app_resource
    -- Description : Процедура отзыва ресурса у АРМа
    -- Params:
    --   p_appid    - код АРМа
    --   p_resid    - код ресурса
    --   p_colnames - список имен реквизитов
    --   p_colvals  - список значений реквизитов
    --
    procedure revoke_app_resource (
      p_appid    in  applist.codeapp%type,
      p_resid    in  sec_resources.res_id%type,
      p_colnames in  t_varchar2list,
      p_colvals  in  t_varchar2list );


    -----------------------------------------------------------------
    -- Procedure   : alter_app_resource
    -- Description : Процедура изменения параметров ресурса у АРМа
    -- Params:
    --   p_appid      - код АРМа
    --   p_resid      - код ресурса
    --   p_pkcolnames - список имен столбцов перв. ключа
    --   p_pkcolvals  - список значений столбцов перв. ключа
    --   p_colnames   - список имен изменяемых реквизитов
    --   p_colvals    - список значений изменяемых реквизитов
    --
    procedure alter_app_resource(
      p_appid      in  applist.codeapp%type,
      p_resid      in  sec_resources.res_id%type,
      p_pkcolnames in  t_varchar2list,
      p_pkcolvals  in  t_varchar2list,
      p_colnames   in  t_varchar2list,
      p_colvals    in  t_varchar2list );


    -----------------------------------------------------------------
    -- Procedure   : change_app_privs
    -- Description : Процедура выдачи/отзыва привилегий пользователям
    --               в зависимости от выданных АРМу функций, справочников
    -- Params:
    --   p_appid - код АРМа
    --
    procedure change_app_privs ( p_appid in applist.codeapp%type );


    -----------------------------------------------------------------
    -- Procedure   : drop_user_resource
    -- Description : Процедура изъятия ресурса у Пользователя
    -- Params:
    --   p_userid     - код Пользователя
    --   p_resid      - код ресурса
    --   p_pkcolnames - список имен столбцов перв. ключа
    --   p_pkcolvals  - список значений столбцов перв. ключа
    --
    procedure drop_user_resource (
      p_userid     in  staff$base.id%type,
      p_resid      in  sec_resources.res_id%type,
      p_pkcolnames in  t_varchar2list,
      p_pkcolvals  in  t_varchar2list );


    -----------------------------------------------------------------
    -- Procedure   : drop_app_resource
    -- Description : Процедура изъятия ресурса у АРМа
    -- Params:
    --   p_appid      - код АРМа
    --   p_resid      - код ресурса
    --   p_pkcolnames - список имен столбцов перв. ключа
    --   p_pkcolvals  - список значений столбцов перв. ключа
    --
    procedure drop_app_resource (
      p_appid      in  applist.codeapp%type,
      p_resid      in  sec_resources.res_id%type,
      p_pkcolnames in  t_varchar2list,
      p_pkcolvals  in  t_varchar2list );


    -----------------------------------------------------------------
    -- CREATE_USER_GTW()
    --
    --     Создание учетной записи пользователя после подтверждения
    --
    --
    --
    procedure create_user_gtw(
                  p_userid      staff$base.id%type );

    -----------------------------------------------------------------
    -- GET_USERPWD_CHANGE()
    --
    --     Получение признак необходимости смены пароля пользователем
    --
    --     Параметры:
    --
    --       p_userid    Ид. пользователя
    --
    function get_userpwd_change(
                  p_userid      staff$base.id%type ) return char;

    -----------------------------------------------------------------
    -- CHANGE_USER_PASSWORD()
    --
    --     Смена пароля пользователя
    --
    --     Параметры:
    --
    --       p_userid    Ид. пользователя
    --
    --       p_password  Пароль пользователя
    --
    procedure change_user_password(
                  p_userid    in staff$base.id%type,
                  p_password  in varchar2            );

    -----------------------------------------------------------------
    -- SET_STAFFTIP_CONTEXT()
    --
    --     Процедура установки контекста для просмотра ресурсов
    --     указанного типового пользователя
    --
    --     Параметры:
    --
    --      p_tipid    Ид. типового пользователя
    --
    procedure set_stafftip_context(
        p_tipid  in  staff$base.tip%type);

    -----------------------------------------------------------------
    -- GRANT_STAFFTIP_RESOURCE()
    --
    --     Процедура выдачи ресурса типовым пользователям
    --
    --     Параметры:
    --
    --         p_tipid     Ид. типового пользователя
    --
    --         p_resid     Ид. ресурса
    --
    --         p_colnames  Список имен реквизитов
    --
    --         p_colvals   Список значений реквизитов
    --
    --
    procedure grant_stafftip_resource(
                  p_tipid    in  staff$base.tip%type,
                  p_resid    in  sec_resources.res_id%type,
                  p_colnames in  t_varchar2list,
                  p_colvals  in  t_varchar2list             );

    -----------------------------------------------------------------
    -- REVOKE_STAFFTIP_RESOURCE()
    --
    --     Процедура отзыва ресурса у типовых пользователей
    --
    --     Параметры:
    --
    --         p_tipid     Ид. типового пользователя
    --
    --         p_resid     Ид. ресурса
    --
    --         p_colnames  Список имен реквизитов
    --
    --         p_colvals   Список значений реквизитов
    --
    --
    procedure revoke_stafftip_resource(
                  p_tipid    in  staff$base.tip%type,
                  p_resid    in  sec_resources.res_id%type,
                  p_colnames in  t_varchar2list,
                  p_colvals  in  t_varchar2list             );

    -----------------------------------------------------------------
    -- ALTER_STAFFTIP_RESOURCE()
    --
    --     Процедура изменения параметров типовых пользователей
    --
    --     Параметры:
    --
    --         p_tipid      Ид. типового пользователя
    --
    --         p_resid      Ид. ресурса
    --
    --         p_pkcolnames Список имен столбцов перв. ключа
    --
    --         p_pkcolvals  Список значений столбцов перв. ключа
    --
    --         p_colnames   Список имен изменяемых реквизитов
    --
    --         p_colvals    Список значений изменяемых реквизитов
    --
    --
    procedure alter_stafftip_resource(
                  p_tipid      in  staff$base.tip%type,
                  p_resid      in  sec_resources.res_id%type,
                  p_pkcolnames in  t_varchar2list,
                  p_pkcolvals  in  t_varchar2list,
                  p_colnames   in  t_varchar2list,
                  p_colvals    in  t_varchar2list             );

    --------------------------------------------------------
    -- CLONE_USER_FROM_STAFFTIP()
    --
    --     Процедура для передачи ресурсов пользователю
    --
    --
    --
    procedure clone_user_from_stafftip (
        p_srcTipId   in  staff$base.tip%type,
        p_dstUserId  in  staff$base.id%type,
        p_reslist    in  t_numberlist,
        p_resclone   in  t_numberlist,
        p_resclean   in  t_numberlist      );

    --------------------------------------------------------
    -- CLONE_STAFFTIP_TO_GROUP()
    --
    --     Процедура для передачи ресурсов пользователям
    --
    --
    --
    procedure clone_stafftip_to_group (
        p_srcTipId   in  staff$base.tip%type,
        p_reslist    in  t_numberlist,
        p_resclone   in  t_numberlist,
        p_resclean   in  t_numberlist      );


end bars_useradm;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_USERADM 
is

    -------------------------------------------------------
    --
    --  Пакет процедур и функций для администрирования
    --             пользователей комплекса
    --
    -------------------------------------------------------

    VERSION_BODY      constant varchar2(64)  := 'version 2.31 05.12.2014';
    VERSION_BODY_DEFS constant varchar2(512) := ''
                      || 'BRANCH      - мультифилиальная схема'||chr(10)
                      || 'SHUSER      - c поддержкой общих пользователей'||chr(10)
                      ;

    -- Код модуля для ошибок и сообщений
    MODCODE           constant varchar2(3) := 'ADM';

    -- Контекст и его переменные
    CTX_USERADM       constant varchar2(30) := 'BARS_USERADM';
    CTXV_USERID       constant varchar2(30) := 'USER_ID';
    CTXV_CMODE        constant varchar2(30) := 'CURRENT_MODE';
    CTXV_CMBRANCH     constant varchar2(30) := 'CURRENT_MBRANCH';

    -- Режим работы с пользователями
    USERMODE_ALL      constant number       := null;
    USERMODE_MBRANCH  constant number       := 0;
    USERMPAR_MBRANCH  constant varchar2(30) := 'MBRANCH';

    -- умолчательные тех. реквизиты пользователя
    USER_SCHEMA       constant varchar2(30) := 'BARS';
    USER_DEFTS        constant varchar2(30) := 'USERS';
    USER_TMPTS        constant varchar2(30) := 'TEMP';

    -- время жизни временной уч. записи (синхронно с BARS_LIC)
    USRLIC_TEMPORARY_LIFETIME constant number   := 31;

    -- признак активности ресурса
    RESOURCE_INACTIVE constant number       := 0;
    RESOURCE_ACTIVE   constant number       := 1;

    -- конф. параметры
    PARAM_LOSEC       constant varchar2(8)  := 'LOSECURE';
    PARAM_SKIPLIC     constant varchar2(8)  := '_SKIPLIC';

    PARAMV_LOSEC      constant number       := 1;
    PARAMV_SKIPLIC    constant varchar2(1)  := 'Y';


    RESOURCE_APPROVED     constant char(1)  := 'Y';
    RESOURCE_NOTAPPROVED  constant char(1)  := 'N';



    subtype t_sqltext           is  varchar2(4000);

    subtype  t_chandle          is  integer;


    --
    -- Глобальные переменные
    --

    -- Текст последнего сообщения
    g_lastmsg         varchar2(4000);





    -----------------------------------------------------------------
    -- ISVC_COLTAB2LIST()
    --
    --     Функция формирует строку из имен столбцов
    --
    --     Параметры:
    --
    --         p_list      Массив строк
    --
    --         p_prefix    Опциональный префикс
    --
    function isvc_coltab2list(
                 p_cols     in  t_anyrow,
                 p_prefix   in  varchar2  default null,
                 p_exclcols in  t_anyrow  default null )  return varchar2
    is
    l_retstr   varchar2(4000) := null;  /*    результируюшая строка */
    l_isfirst  boolean        := true;  /* признак первого элемента */
    l_isincl   boolean        := true;  /*       признак исключения */
    begin

        for i in 1..p_cols.count
        loop

            if (p_exclcols is not null) then

                for j in 1..p_exclcols.count
                loop
                    if (p_cols(i).column_name = p_exclcols(j).column_name) then
                        l_isincl := false;
                    end if;
                end loop;
            end if;

            if (l_isincl) then

                if (l_isfirst) then
                    l_isfirst := false;
                else
                    l_retstr := l_retstr || ',';
                end if;

                l_retstr := l_retstr || p_prefix || p_cols(i).column_name;
            end if;

            l_isincl := true;

        end loop;

        return l_retstr;

    end isvc_coltab2list;



    -----------------------------------------------------------------
    -- ISVC_COLTAB2PAIR()
    --
    --     Функция формирует строку из имен столбцов вида
    --     <col> = :<col><sepchar>...
    --
    --     Параметры:
    --
    --         p_list      Массив строк
    --
    --         p_sepchar   Подстрока разделителя
    --
    function isvc_coltab2pair(
                 p_cols     in  t_anyrow,
                 p_sepchar  in  varchar2  default ',',
                 p_exclcols in  t_anyrow  default null )  return varchar2
    is
    l_retstr   varchar2(4000) := null;  /*    результируюшая строка */
    l_isfirst  boolean        := true;  /* признак первого элемента */
    l_isincl   boolean        := true;  /*       признак исключения */
    begin

        for i in 1..p_cols.count
        loop

            if (p_exclcols is not null) then

                for j in 1..p_exclcols.count
                loop
                    if (p_cols(i).column_name = p_exclcols(j).column_name) then
                        l_isincl := false;
                    end if;
                end loop;
            end if;

            if (l_isincl) then

                if (l_isfirst) then
                    l_isfirst := false;
                else
                    l_retstr := l_retstr || p_sepchar;
                end if;

                l_retstr := l_retstr || p_cols(i).column_name || ' = :' || p_cols(i).column_name;

            end if;

            l_isincl := true;

        end loop;

        return l_retstr;

    end isvc_coltab2pair;







    -----------------------------------------------------------------
    -- ISVC_CPREP()
    --
    --     Функция создания и разбора курсора, возвращает идент.
    --     созданного курсора
    --
    --     Параметры:
    --
    --         p_stmt      Текст запроса
    --
    --
    function isvc_cprep(
                 p_stmt    in  t_sqltext)  return t_chandle
    is
    l_cno      t_chandle;             /*           идент. курсора */
    begin
        l_cno := dbms_sql.open_cursor;
        dbms_sql.parse(l_cno, p_stmt, dbms_sql.native);
        return l_cno;
    end isvc_cprep;


    -----------------------------------------------------------------
    -- ISVC_CDEFCOL()
    --
    --     Процедура определения (назначения) типов для столбцов
    --     созданного запроса (курсора)
    --
    --     Параметры:
    --
    --         p_cno      Текст запроса
    --
    --         p_cols     Список столбцов
    --
    procedure isvc_cdefcol(
                 p_cno    in  t_chandle,
                 p_cols   in  t_anyrow  )
    is

    /* определяем стандартные типы */
    l_varchar2  varchar2(4000);
    l_char      char(1000);
    l_number    number;
    l_date      date;

    begin

        for i in 1..p_cols.count
        loop
            case
                when (p_cols(i).column_type = 'VARCHAR2') then
                    dbms_sql.define_column(p_cno, i, l_varchar2, p_cols(i).column_size);
                when (p_cols(i).column_type = 'CHAR') then
                    dbms_sql.define_column(p_cno, i, l_char, p_cols(i).column_size);
                when (p_cols(i).column_type = 'NUMBER') then
                    dbms_sql.define_column(p_cno, i, l_number);
                when (p_cols(i).column_type = 'DATE') then
                    dbms_sql.define_column(p_cno, i, l_date);
                else
                    bars_error.raise_nerror(MODCODE, 'UNSUPPORTED_RESOURCE_DATATYPE');
             end case;
        end loop;

    end isvc_cdefcol;


    -----------------------------------------------------------------
    -- ISVC_CBIND()
    --
    --     Процедура привязки значений к курсору
    --
    --     Параметры:
    --
    --         p_cno      Идент. курсора
    --
    --         p_vals     Список столбцов со значениями
    --
    procedure isvc_cbind(
                 p_cno      in  t_chandle,
                 p_vals     in  t_anyrow,
                 p_exclcols in  t_anyrow  default null)
    is
    pn          constant varchar2(100) := 'useradm.isvccbind';

    /* определяем стандартные типы */
    l_varchar2  varchar2(4000);
    l_char      char(1000);
    l_number    number;
    l_date      date;

    l_ret       number;
    l_isincl   boolean        := true;  /*       признак исключения */

    begin

        for i in 1..p_vals.count
        loop

            if (p_exclcols is not null) then

                for j in 1..p_exclcols.count
                loop
                    if (p_vals(i).column_name = p_exclcols(j).column_name) then
                        l_isincl := false;
                    end if;
                end loop;
            end if;

            if (l_isincl) then

                case
                    when (p_vals(i).column_type = 'VARCHAR2') then
                        l_ret := p_vals(i).column_data.getvarchar(l_varchar2);
                        dbms_sql.bind_variable(p_cno, ':' || p_vals(i).column_name, l_varchar2);
                        bars_audit.trace('%s: bind column %s to value %s', pn, p_vals(i).column_name, l_varchar2);
                    when (p_vals(i).column_type = 'CHAR'    ) then
                        l_ret := p_vals(i).column_data.getvarchar(l_varchar2);
                        dbms_sql.bind_variable_char(p_cno, ':' || p_vals(i).column_name, l_varchar2, p_vals(i).column_size);
                        bars_audit.trace('%s: bind column %s to value %s (%s)', pn, p_vals(i).column_name, l_varchar2, to_char(p_vals(i).column_size));
                    when (p_vals(i).column_type = 'NUMBER'  ) then
                        l_ret := p_vals(i).column_data.getnumber(l_number);
                        dbms_sql.bind_variable(p_cno, ':' || p_vals(i).column_name, l_number);
                        bars_audit.trace('%s: bind column %s to value %s', pn, p_vals(i).column_name, to_char(l_number));
                    when (p_vals(i).column_type = 'DATE'    ) then
                        l_ret := p_vals(i).column_data.getdate(l_date);
                        dbms_sql.bind_variable(p_cno, ':' || p_vals(i).column_name, l_date);
                        bars_audit.trace('%s: bind column %s to value %s', pn, p_vals(i).column_name, to_char(l_date, 'dd.mm.yyyy hh24:mi:ss'));
                    else
                        bars_error.raise_nerror(MODCODE, 'UNSUPPORTED_RESOURCE_DATATYPE');
                end case;

            end if;

            l_isincl := true;

        end loop;

    end isvc_cbind;


    -----------------------------------------------------------------
    -- ISVC_CGETVAL()
    --
    --     Процедура получения значений для строки курсора
    --
    --     Параметры:
    --
    --         p_cno      Текст запроса
    --
    --         p_cols     Список столбцов
    --
    --         p_vals     Список значений
    --
    procedure isvc_cgetval(
                 p_cno    in      t_chandle,
                 p_cols   in      t_anyrow,
                 p_vals   in out  t_anyrow   )
    is

    /* определяем стандартные типы */
    l_varchar2  varchar2(4000);
    l_char      char(1000);
    l_number    number;
    l_date      date;

    begin

        -- Инициализируем или очищаем
        if (p_vals is null) then
            p_vals := t_anyrow();
        else
            p_vals.delete;
        end if;

        for i in 1..p_cols.count
        loop
            p_vals.extend;
            p_vals(i) := p_cols(i);

            case
                when (p_cols(i).column_type = 'VARCHAR2') then
                    dbms_sql.column_value(p_cno, i, l_varchar2);
                    p_vals(i).column_data := anydata.convertvarchar(l_varchar2);
                when (p_cols(i).column_type = 'CHAR') then
                    dbms_sql.column_value(p_cno, i, l_varchar2);
                    p_vals(i).column_data := anydata.convertvarchar(l_varchar2);
                when (p_cols(i).column_type = 'NUMBER') then
                    dbms_sql.column_value(p_cno, i, l_number);
                    p_vals(i).column_data := anydata.convertnumber(l_number);
                when (p_cols(i).column_type = 'DATE') then
                    dbms_sql.column_value(p_cno, i, l_date);
                    p_vals(i).column_data := anydata.convertdate(l_date);
                    dbms_sql.define_column(p_cno, i, l_date);
                else
                    bars_error.raise_nerror(MODCODE, 'UNSUPPORTED_RESOURCE_DATATYPE');
             end case;
        end loop;

    end isvc_cgetval;


    -----------------------------------------------------------------
    -- ICNV_COLS()
    --
    --     Процедура перекодировки данных во внутренние используемые
    --     в пакете типы и структуры
    --
    --     Параметры:
    --
    --         p_resid     Ид. ресурса
    --
    --         p_colnames  Список имен реквизитов
    --
    --         p_colvals   Список значений реквизитов
    --
    --         p_resrow    Строка изменений
    --
    procedure icnv_cols(
                  p_resid    in     sec_resources.res_id%type,
                  p_colnames in     t_varchar2list,
                  p_colvals  in     t_varchar2list,
                  p_resrow   in out t_anyrow            )
    is
    l_tabname     varchar2(30);
    l_column_type varchar2(30);
    l_column_size number(10);
    begin

        select res_tabname into l_tabname
          from sec_resources
         where res_id = p_resid;

        for i in 1..p_colnames.count
        loop

            begin

                select data_type, data_length
                  into l_column_type, l_column_size
                  from user_tab_columns
                 where table_name = l_tabname
                   and column_name = p_colnames(i);

                p_resrow.extend;
                p_resrow(i).column_name := p_colnames(i);
                p_resrow(i).column_type := l_column_type;
                p_resrow(i).column_size := l_column_size;

                case
                    when (p_resrow(i).column_type = 'VARCHAR2') then
                        p_resrow(i).column_data := anydata.convertvarchar(p_colvals(i));
                    when (p_resrow(i).column_type = 'CHAR') then
                        p_resrow(i).column_data := anydata.convertvarchar(p_colvals(i));
                    when (p_resrow(i).column_type = 'NUMBER') then
                        p_resrow(i).column_data := anydata.convertnumber(to_number(p_colvals(i)));
                    when (p_resrow(i).column_type = 'DATE') then
                        p_resrow(i).column_data := anydata.convertdate(to_date(p_colvals(i), 'dd.mm.yyyy hh24:mi:ss'));
                    else
                        bars_error.raise_nerror(MODCODE, 'UNSUPPORTED_RESOURCE_DATATYPE');
                end case;

            exception when no_data_found then null;
            end;

        end loop;

    end icnv_cols;


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
        return 'package header BARS_USERADM ' || VERSION_HEADER || chr(10) ||
               'package header definition(s):' || chr(10) || VERSION_HEADER_DEFS;
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
        return 'package body BARS_USERADM ' || VERSION_BODY || chr(10) ||
               'package body definition(s):' || chr(10) || VERSION_BODY_DEFS;
    end body_version;


    -----------------------------------------------------------------
    -- GET_PARAM()
    --
    --     Функция получения значения конфигурационного параметра
    --     Возвращает NULL если параметр не найден
    --
    --     Параметры:
    --
    --         p_parname    Имя конф. параметра
    --
    function get_param(
                 p_parname in params.par%type ) return params.val%type
    is

    l_res   params.val%type;   /* установленное значение */

    begin
        select val into l_res
          from params
         where par = p_parname;

        return l_res;
    exception
        when NO_DATA_FOUND then return null;
    end get_param;



    --------------------------------------------------------
    -- GET_PROFILE_LIMITS()
    --
    --     Функция построения строки с ограничениями профайла
    --     для генерации SQL-выражения
    --
    --
    function get_profile_limits(
        p_profile       in  staff_profiles.profile%type) return varchar2
    is

    l_stmt        varchar2(4000);             /*       подстрока для SQL-выражения */
    l_recProfile  staff_profiles%rowtype;     /* запись о пользовательском профиле */

    begin

        bars_audit.trace('bars_useradm.get_profile_limits entry point');

        select * into l_recProfile
          from staff_profiles
         where profile = upper(p_profile);

        --
        -- Формируем строку
        --
        l_stmt := ' password_life_time ' || nvl(to_char(l_recProfile.pwd_expire_time), 'default');
        l_stmt := l_stmt || ' password_grace_time '      || nvl(to_char(l_recProfile.pwd_grace_time), 'default');
        l_stmt := l_stmt || ' password_reuse_max '       || nvl(to_char(l_recProfile.pwd_reuse_max), 'default');
        l_stmt := l_stmt || ' password_reuse_time '      || nvl(to_char(l_recProfile.pwd_reuse_time), 'default');

        if (l_recProfile.pwd_verify_func is not null) then
            l_stmt := l_stmt || ' password_verify_function ' || l_recProfile.pwd_verify_func;
        end if;

        l_stmt := l_stmt || ' password_lock_time '       || nvl(to_char(l_recProfile.pwd_lock_time), 'default');
        l_stmt := l_stmt || ' failed_login_attempts '    || nvl(to_char(l_recProfile.user_max_login), 'default');
        l_stmt := l_stmt || ' sessions_per_user '        || nvl(to_char(l_recProfile.user_max_session), 'default');

        bars_audit.trace('bars_useradm.get_profile_limits end');

        return l_stmt;

    exception
        when NO_DATA_FOUND then
            bars_audit.trace('bars_useradm.get_profile_limits error: profile does not exists');
            bars_audit.error('USERADM: Профиль ' || upper(p_profile) || ' не найден');
            -- '\902 Профиль ' || upper(p_profile) || ' не найден'
            bars_error.raise_error(MODCODE, 1, upper(p_profile));
    end get_profile_limits;



    --------------------------------------------------------
    -- SYNC_PROFILE()
    --
    --     Процедура синхронизации пользовательского профиля
    --     с профайлом БД
    --
    --
    procedure sync_profile(
        p_profile       in  staff_profiles.profile%type,
        p_synctype      in  varchar2,
        p_syncaction    in  varchar2                    )
    is
    begin

        bars_audit.trace('bars_useradm.sync_profile entry point');
        bars_audit.trace('bars_useradm.sync_profile par[0]=>%s, par[1]=>%s', p_profile, p_synctype);

        -- Проверяем тип синхранизации
        if (p_synctype not in ('IN', 'OUT')) then
            bars_audit.trace('bars_useradm.sync_profile unknown sync type');
            bars_audit.error('USERADM: \0900 Неверный тип синхронизации профилей');
            -- '\900 Неверный тип синхронизации профилей'
            bars_error.raise_error(MODCODE, 2);
        end if;

        if (p_synctype = 'OUT') then

            -- Проверяем допустимость действия
            if (p_syncaction is not null and p_syncaction not in ('CREATE', 'DROP', 'ALTER')) then
                bars_audit.trace('bars_useradm.sync_profile unknown sync action');
                bars_audit.error('USERADM: \901 Неверный тип действия синхронизации профилей');
                -- '\901 Неверный тип действия синхронизации профилей'
                bars_error.raise_error(MODCODE, 3);
            end if;

        end if;

        if (p_synctype = 'OUT') then

            if    (p_syncaction = 'CREATE') then
                execute immediate 'create profile ' || p_profile || ' limit ' || get_profile_limits(p_profile);
            elsif (p_syncaction = 'ALTER') then
                execute immediate 'alter profile ' || p_profile || ' limit ' || get_profile_limits(p_profile);
            else
                execute immediate 'drop profile ' || p_profile;
            end if;
        else
            -- add sync in code
            null;
        end if;

        bars_audit.security('USERADM: Синхронизирован пользовательский профиль ' || upper(p_profile));
        bars_audit.trace('bars_useradm.sync_profile end');

    end sync_profile;


    --------------------------------------------------------
    -- CREATE_PROFILE()
    --
    --     Процедура создания пользовательского профиля
    --
    --
    --
    procedure create_profile(
        p_profile       in  staff_profiles.profile%type,
        p_pwdexpiretime in  staff_profiles.pwd_expire_time%type    default null,
        p_pwdgracetime  in  staff_profiles.pwd_grace_time%type     default null,
        p_pwdreusemax   in  staff_profiles.pwd_reuse_max%type      default null,
        p_pwdreusetime  in  staff_profiles.pwd_reuse_time%type     default null,
        p_pwdverifyfunc in  staff_profiles.pwd_verify_func%type    default null,
        p_pwdlocktime   in  staff_profiles.pwd_lock_time%type      default null,
        p_usrmaxlogin   in  staff_profiles.user_max_login%type     default null,
        p_usrmaxsession in  staff_profiles.user_max_session%type   default null )
    is
    begin

        bars_audit.trace('bars_useradm.create_profile entry point');

        begin
            insert into staff_profiles(profile, pwd_expire_time, pwd_grace_time,
                                       pwd_reuse_max, pwd_reuse_time, pwd_verify_func,
                                       pwd_lock_time, user_max_login, user_max_session )
            values (upper(p_profile), p_pwdexpiretime, p_pwdgracetime,
                    p_pwdreusemax, p_pwdreusetime, p_pwdverifyfunc,
                    p_pwdlocktime, p_usrmaxlogin, p_usrmaxsession  );
        exception
            when DUP_VAL_ON_INDEX then
                bars_audit.trace('bars_useradm.create_profile error: profile already exists');
                bars_audit.error('USERADM: Профиль ' || upper(p_profile) || ' уже существует');
                -- '\903 Профиль ' || upper(p_profile) || ' уже существует'
                bars_error.raise_error(MODCODE, 4, upper(p_profile));
        end;

        begin
            sync_profile(p_profile, 'OUT', 'CREATE');
        exception
            when OTHERS then

                /* error create profile - recover table changes */
                delete from staff_profiles
                 where profile = upper(p_profile);
                commit;

                raise;
        end;

        bars_audit.security('USERADM: Создан пользовательский профиль ' || upper(p_profile));
        bars_audit.trace('bars_useradm.create_profile end');

    end create_profile;


    --------------------------------------------------------
    -- DROP_PROFILE()
    --
    --     Процедура удаления пользовательского профиля
    --
    --
    --
    procedure drop_profile(
        p_profile    in  staff_profiles.profile%type)
    is
    begin

        bars_audit.trace('bars_useradm.drop_profile entry point');

        delete from staff_profiles
        where profile = upper(p_profile);

        begin
            sync_profile(p_profile, 'OUT', 'DROP');
        exception
            when OTHERS then
                if (sqlcode = -2380) then null; /* profile does not exist */
                else raise;
                end if;
        end;

        bars_audit.security('USERADM: Удален пользовательский профиль ' || upper(p_profile));
        bars_audit.trace('bars_useradm.drop_profile end');

    -- exception
    --    when OTHERS then
    --        if (sqlcode = -) then
    --            bars_audit.trace('');
    --
    --
    --        else raise;
    --        end if;
    end drop_profile;



    --------------------------------------------------------
    -- ALTER_PROFILE()
    --
    --     Процедура изменения пользовательского профиля
    --
    --
    --
    procedure alter_profile(
        p_profile    in  staff_profiles.profile%type,
        p_pwdexpiretime in  staff_profiles.pwd_expire_time%type,
        p_pwdgracetime  in  staff_profiles.pwd_grace_time%type,
        p_pwdreusemax   in  staff_profiles.pwd_reuse_max%type,
        p_pwdreusetime  in  staff_profiles.pwd_reuse_time%type,
        p_pwdverifyfunc in  staff_profiles.pwd_verify_func%type,
        p_pwdlocktime   in  staff_profiles.pwd_lock_time%type,
        p_usrmaxlogin   in  staff_profiles.user_max_login%type,
        p_usrmaxsession in  staff_profiles.user_max_session%type )
    is

    l_recProfile   staff_profiles%rowtype;   /* Старые параметры профиля */

    begin

        bars_audit.trace('bars_useradm.alter_profile entry point');

        begin
            select * into l_recProfile
              from staff_profiles
             where profile = upper(p_profile);
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('bars_useradm.alter_profile error: profile does not exists');
                bars_audit.error('USERADM: Профиль ' || upper(p_profile) || ' не найден');
                -- '\902 Профиль ' || upper(p_profile) || ' не найден'
                bars_error.raise_error(MODCODE, 1, upper(p_profile));
        end;

        update staff_profiles
           set pwd_expire_time  = p_pwdexpiretime,
               pwd_grace_time   = p_pwdgracetime,
               pwd_reuse_max    = p_pwdreusemax,
               pwd_reuse_time   = p_pwdreusetime,
               pwd_verify_func  = p_pwdverifyfunc,
               pwd_lock_time    = p_pwdlocktime,
               user_max_login   = p_usrmaxlogin,
               user_max_session = p_usrmaxsession
         where profile = upper(p_profile);

         begin
             sync_profile(p_profile, 'OUT', 'ALTER');
         exception
             when OTHERS then

                 update staff_profiles
                    set pwd_expire_time  = l_recProfile.pwd_expire_time,
                        pwd_grace_time   = l_recProfile.pwd_grace_time,
                        pwd_reuse_max    = l_recProfile.pwd_reuse_max,
                        pwd_reuse_time   = l_recProfile.pwd_reuse_time,
                        pwd_verify_func  = l_recProfile.pwd_verify_func,
                        pwd_lock_time    = l_recProfile.pwd_lock_time,
                        user_max_login   = l_recProfile.user_max_login,
                        user_max_session = l_recProfile.user_max_session
                  where profile = upper(l_recProfile.profile);
                 commit;

                 if (sqlcode = - 7443) then
                     -- '\904 Функция проверки пароля ' || upper(p_pwdverifyfunc) || ' не найдена'
                     bars_error.raise_error(MODCODE, 5, upper(p_pwdverifyfunc));
                 else raise;
                 end if;
         end;

        bars_audit.security('USERADM: Изменен пользовательский профиль ' || upper(p_profile));
        bars_audit.trace('bars_useradm.alter_profile end');

    end alter_profile;





    -----------------------------------------------------------------
    -- VALIDATE_USERID()
    --
    --     Процедура проверки существования пользователя по его
    --     идентификатору
    --
    --     Параметры:
    --
    --         p_userid       Идентификатор пользователя
    --
    --
    procedure validate_userid(
        p_userid    in  staff$base.id%type)
    is
    p          constant varchar2(100) := 'useradm.usrvldid';
    l_dummy    number;
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_userid));
        select 1 into l_dummy
          from staff$base
         where id = p_userid;
        bars_audit.trace('%s: user id=%s exists', p, to_char(p_userid));
    exception
        when NO_DATA_FOUND then
            bars_audit.trace('%s: error detected - user with id %s not found', p, to_char(p_userid));
            bars_error.raise_nerror(MODCODE, 'USER_NOT_FOUND', to_char(p_userid));
    end validate_userid;


    -----------------------------------------------------------------
    -- GET_USER_FIO()
    --
    --     Функция получения ФИО пользователя по его идентификатору
    --
    --     Параметры:
    --
    --         p_userid       Идентификатор пользователя
    --
    --
    function get_user_fio(
        p_userid    in  staff$base.id%type) return staff$base.fio%type
    is
    p          constant varchar2(100) := 'useradm.getusrfio';
    l_usrfio   staff$base.fio%type;   /* ФИО пользователя */
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_userid));
        select fio into l_usrfio
          from staff$base
         where id = p_userid;
        bars_audit.trace('%s: user id=%s fio=%s', to_char(p_userid), l_usrfio);

        return l_usrfio;
    exception
        when NO_DATA_FOUND then
            bars_audit.trace('%s: error detected - user with id %s not found', p, to_char(p_userid));
            bars_error.raise_nerror(MODCODE, 'USER_NOT_FOUND', to_char(p_userid));
    end get_user_fio;


    -----------------------------------------------------------------
    -- IMAKE_TKEY()
    --
    --     Функция расчета временной контрольной суммы записи
    --     пользователя
    --
    --     Параметры:
    --
    --         p_username    Имя учетной записи
    --
    --
    function imake_tkey(
                 p_recid      in staff$base.id%type,
                 p_reclogname in staff$base.logname%type,
                 p_recexp     in staff$base.expired%type ) return varchar2
    is

    l_chksum        staff$base.chksum%type;  /*          контрольная сумма записи */
    l_buf           varchar2(1000);          /*                      буфер данных */

    begin

        l_buf := to_char(p_recid) || p_reclogname || '1' ||
                 to_char(p_recexp, 'ddmmyyyyhh24miss');
        bars_audit.trace('adm: %s', l_buf);

        l_chksum := to_hex(dbms_obfuscation_toolkit.md5(input_string=> l_buf));

        return l_chksum;

    end imake_tkey;

    -----------------------------------------------------------------
    --     get_sha1()
    -----------------------------------------------------------------
    --     Функция получения SHA1
    --

    function get_sha1(p_string varchar2) return varchar2
    is
     --
     l_stmt varchar2(4000);
     --
    begin
     --
        l_stmt:= lower (to_char (rawtohex (dbms_crypto.hash (src   => utl_raw.cast_to_raw (lower(p_string)),
                                                             typ   => dbms_crypto.hash_sh1))));
     --
        return l_stmt;
     --
    end;


    -----------------------------------------------------------------
    -- CREATE_USER()
    --
    --     Процедура создания пользователя комплекса
    --
    --
    --
    --
    procedure create_user(
                  p_usrfio      in  staff$base.fio%type,
                  p_usrtabn     in  staff$base.tabn%type,
                  p_usrtype     in  staff$base.clsid%type,
                  p_usraccown   in  staff$base.type%type,
                  p_usrbranch   in  varchar2,
                  p_usrusearc   in  staff$base.usearc%type,
                  p_usrusegtw   in  staff$base.usegtw%type,
                  p_usrwprof    in  staff$base.web_profile%type,
                  p_reclogname  in  staff$base.logname%type,
                  p_recpasswd   in  varchar2,
                  p_recappauth  in  varchar2,
                  p_recprof     in  varchar2,
                  p_recdefrole  in  varchar2,
                  p_recrsgrp    in  varchar2,
                  p_usrid       in  staff$base.id%type default null,
                  p_gtwpasswd   in  varchar2           default null,
                  p_canselectbranch in staff$base.can_select_branch%type default null,
                  p_chgpwd      in  char               default null,
                  p_tipid       in  number             default null )

    is

    p          constant varchar2(30) := 'useradm.crusr';

    l_reclogname varchar2(30 char) default trim(p_reclogname);
    l_usrid       staff$base.id%type;       /*                   ид. созданного пользователя */
    l_usrtabn     staff$base.tabn%type;     /*                  табельный номер пользователя */
    l_usrapprove  staff$base.approve%type;  /*                         признак подтверждения */
    l_usrdefts    varchar2(30);             /* умолчательное табл. пространство пользователя */
    l_usrtmpts    varchar2(30);             /* временное табличное пространство пользователя */

    l_usrstmtcr   varchar2(4000);
    l_usrstmtgr   varchar2(4000);
    l_usrstmtdr   varchar2(4000);

    l_gtwtaskid   number := 1;
--    l_gtwpasswd   varchar2(128);

    l_licpermfree number;                 /*                   кол-во неиспольз. лицензий */
    l_lictempfree number;                 /*         кол-во неиспольз. временных лицензий */

    l_reclicexp   date;                   /*       срок действия временной учетной записи */
    l_reclickey   staff$base.chksum%type; /*               лицензионный ключ пользователя */

    l_gtwuserid   number;                 /*                       ид. пользователя шлюза */
    l_cnt         number;                 /*                               просто счетчик */

    begin
        bars_audit.trace('%s: entry point', p);
/*
        -- Получаем инф. о свободных лицензиях
        bars_lic.get_user_license(l_licpermfree, l_lictempfree);
        bars_audit.trace('%s: free user licenses is %s, free temp user licenses is %s', p, to_char(l_licpermfree), to_char(l_lictempfree));

        -- если лицензий больше нет, выходим
        if (l_licpermfree = 0 and l_lictempfree = 0) then
            bars_audit.trace('%s: error detected - no licence left', p);
            bars_error.raise_nerror(MODCODE, 'USERLIMIT_EXCEED');
        end if;
*/
        -- Получаем имена табл. пространств
        l_usrdefts := nvl(get_param('USRDEFTS'), USER_DEFTS);
        l_usrtmpts := nvl(get_param('USRTMPTS'), USER_TMPTS);
        bars_audit.trace('%s: defts=%s tmpts=%s', p, l_usrdefts, l_usrtmpts);

        -- Приводим табельный номер в верхний регистр
        l_usrtabn := upper(ltrim(rtrim(p_usrtabn)));

        -- Получаем ид. пользователя
        if (p_usrid is not null) then
            bars_audit.trace('%s: specified user id %s, checking for existing ...', p, to_char(p_usrid));
            -- Проверяем наличие такого пользователя
            select count(*) into l_cnt
              from staff$base
             where id = p_usrid;

            if (l_cnt != 0) then
                bars_error.raise_nerror(MODCODE, 'USER_ALREADY_EXISTS', to_char(p_usrid));
            end if;

            l_usrid := p_usrid;
        else
            l_usrid := bars_sqnc.get_nextval('s_staff');
        end if;

        -- если будет использоваться временная лицензия, рассчитываем ключ
        if (l_licpermfree = 0) then
            l_reclicexp := sysdate + USRLIC_TEMPORARY_LIFETIME -1;
            l_reclickey := imake_tkey(l_usrid, l_reclogname, l_reclicexp);
            bars_audit.trace('%s: user license expired date and key generated. (%s)', p, l_reclickey);
        end if;

        -- создаем пользователя

        -- Выражение на создание пользователя
        l_usrstmtcr := 'create user ' || l_reclogname || ' identified by ' || p_recpasswd ||
                       ' default tablespace ' || l_usrdefts || ' temporary tablespace ' || l_usrtmpts;

        if (p_recprof is not null) then
            l_usrstmtcr := l_usrstmtcr || ' profile "' || p_recprof || '"';
        end if;
        bars_audit.info(p || ': database account stmt=>' || l_usrstmtcr );

        if (p_usrusegtw != 1) then

            -- создаем пользователя
            execute immediate l_usrstmtcr;
            bars_audit.trace('%s: database account created.', p);

            -- даем квоту на табл. пространство
            execute immediate 'alter user ' || l_reclogname || ' quota unlimited on ' || l_usrdefts;
            bars_audit.trace('%s: qouta granted.', p);

            -- даем право на соединение
            execute immediate 'grant create session to ' || l_reclogname;
            bars_audit.trace('%s: create session granted.', p);

            if (p_recdefrole is not null) then
                -- выдаем умолчательную роль
                execute immediate 'grant ' || p_recdefrole || ' to ' || l_reclogname;
                bars_audit.trace('%s: default role %s granted.', p, p_recdefrole);

                -- устанавливаем умолчат. роль
                execute immediate 'alter user ' || l_reclogname || ' default role ' || p_recdefrole;
                bars_audit.trace('%s: default role %s is set for user.', p, p_recdefrole);
            end if;

            if (p_recappauth is not null) then
                -- разрешаем работу через proxy-пользователя
                execute immediate 'alter user ' || l_reclogname || ' grant connect through "' || p_recappauth || '"';
                bars_audit.trace('%s: connect through %s granted to user.', p, p_recappauth);
            end if;

        end if;

        -- состояние подтверждения
        if (p_usrusegtw = 1) then
            l_usrapprove := USER_NOTAPPROVED;
        else
            l_usrapprove := USER_APPROVED;
        end if;

        -- заносим информацию в справочник
        begin

            insert into staff$base(id, fio, logname, type, tabn, disable, clsid, approve,
                                   web_profile, usearc, cschema, usegtw, active, branch,
                                   can_select_branch,
                                   created, expired, chksum, chgpwd, tip )
            values (l_usrid, p_usrfio, l_reclogname, p_usraccown, l_usrtabn,
                    USER_ENABLED, p_usrtype, l_usrapprove, p_usrwprof, p_usrusearc,
                    USER_SCHEMA, p_usrusegtw, USER_STATE_ACTIVE, p_usrbranch, p_canselectbranch,
                    sysdate, l_reclicexp, l_reclickey, p_chgpwd, p_tipid )
            returning id into l_usrid;

        --Вставка в WEB_USERMAP
         if (p_recappauth is not null) then
            web_utl_adm.set_webuser(
                                    webuser_   => lower(l_reclogname),
                                    dbuser_    => upper(l_reclogname),
                                    webpass_   => null,
                                    blocked_   => 0,
                                    errmode_   => 1,
                                    adminpass_ => get_sha1(p_recpasswd),
                                    comm_      => p_usrfio||'(Код='||l_usrid||')');
        end if;



            bars_audit.trace('%s: user record created, user id is %s', p, to_char(l_usrid));

            -- Добавляем разрешенное отделение (TOБО)
            begin
                select count(*) into l_cnt
                  from staff_branch
                 where id     = l_usrid
                   and branch = p_usrbranch;

                if (l_cnt = 0) then
                    insert into staff_branch(id, branch)
                    values (l_usrid, p_usrbranch);
                end if;
            exception
                when DUP_VAL_ON_INDEX then null;
            end;
            bars_audit.trace('%s: user default branch is set', p);

            -- Добавляем параметры входа для шлюза
            if (p_usrusegtw = 1) then
                insert into sec_logins (secid, taskid, oralogin, orapassword)
                values (l_usrtabn, l_gtwtaskid, l_reclogname, p_gtwpasswd );
                bars_audit.trace('%s: user gateway login parameters stored.', p);
            end if;
/*
            -- рассчитываем ключ
            bars_lic.set_user_license(p_reclogname);
            bars_audit.trace('%s: user license generated.', p);
*/
        exception
            when OTHERS then
                rollback;
                if (p_usrusegtw != 1) then
                    execute immediate 'drop user ' || l_reclogname;
                end if;
                raise;
        end;

        if (p_usrusegtw = 1) then
            -- сохраняем запрос на создание
            -- l_gtwuserid := gate_user_id;
            insert into staff_storage(id, storage_stmt, grantor, grants, roles)
            values (l_usrid, l_usrstmtcr, user_id, l_usrdefts, p_recdefrole);
            bars_audit.trace('%s: user create statement stored.', p);
        end if;

        commit;

        -- формируем сообщение
        if (l_licpermfree = 0) then
            g_lastmsg := bars_msg.get_msg(MODCODE, 'TEMPORARY_USER_CREATED', l_reclogname);
        else
            g_lastmsg := bars_msg.get_msg(MODCODE, 'USER_CREATED', l_reclogname); -- 'Наташенька-золотце');
        end if;


        bars_audit.trace('%s: succ end', p);

    end create_user;


    -----------------------------------------------------------------
    -- ALTER_USER()
    --
    --     Процедура обновление параметров пользователя
    --
    --
    --
    --
    procedure alter_user(
                  p_usrid       in  staff$base.id%type,
                  p_usrfio      in  staff$base.fio%type,
                  p_usrtabn     in  staff$base.tabn%type,
                  p_usrtype     in  staff$base.clsid%type,
                  p_usraccown   in  staff$base.type%type,
                  p_usrbranch   in  varchar2,
                  p_usrusearc   in  staff$base.usearc%type,
                  p_usrusegtw   in  staff$base.usegtw%type,
                  p_usrwprof    in  staff$base.web_profile%type,
                  p_recpasswd   in  varchar2,
                  p_recappauth  in  varchar2,
                  p_recprof     in  varchar2,
                  p_recdefrole  in  varchar2,
                  p_recrsgrp    in  varchar2,
                  p_canselectbranch in staff$base.can_select_branch%type default null,
                  p_chgpwd      in  char               default null,
                  p_tipid       in  number             default null )
    is

    p          constant varchar2(30) := 'useradm.chgusr';

    l_usrlogname     staff$base.logname%type;
    l_cnt            number;


    begin
        bars_audit.trace('%s: entry point', p);

        -- проверяем существование и получаем logname
        begin
            select logname into l_usrlogname
              from staff$base
             where id = p_usrid;
            bars_audit.trace('%s: user logname is %s', p, l_usrlogname);
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('%s: error - user not found by id %s', p, to_char(p_usrid));
                bars_error.raise_nerror(MODCODE, 'USER_NOT_FOUND', to_char(p_usrid));
        end;

        -- обновляем реквизиты
        update staff$base
           set fio         = p_usrfio,
               type        = p_usraccown,
               tabn        = p_usrtabn,
               clsid       = p_usrtype,
               branch      = p_usrbranch,
               web_profile = p_usrwprof,
               usearc      = p_usrusearc,
               usegtw      = p_usrusegtw,
               can_select_branch = p_canselectbranch,
               chgpwd      = p_chgpwd,
               tip         = p_tipid
         where id = p_usrid;

        -- вносим отделение в список доступных
        begin
            select count(*) into l_cnt
              from staff_branch
             where id     = p_usrid
               and branch = p_usrbranch;

            if (l_cnt = 0) then
                insert into staff_branch(id, branch)
                values (p_usrid, p_usrbranch);
            end if;
        exception
            when DUP_VAL_ON_INDEX then null;
        end;

        -- Смена пароля (TODO: смена пароля при использовании шлюза)
        if (p_recpasswd is not null) then
            execute immediate 'alter user ' || l_usrlogname || ' identified by ' || p_recpasswd;
        end if;

        -- Меняем proxy пользователя
        if (p_recappauth is not null) then
            execute immediate 'alter user ' || l_usrlogname || ' grant connect through "' || p_recappauth || '"';
         --Если стоит прокси проверяем пароль так как он нам очень-очень нужен
          if (p_recpasswd is not null) then
          --если он заполнен - заносим в web_usermap
            web_utl_adm.set_webuser(
                                                webuser_   => lower(l_usrlogname),
                                                dbuser_    => upper(l_usrlogname),
                                                webpass_   => null,
                                                blocked_   => 0,
                                                errmode_   => 1,
                                                adminpass_ => get_sha1(p_recpasswd),
                                                comm_      => p_usrfio||'(Код='||p_usrid||')');
          --else
            --raise_application_error(-20000, 'Змініть будь-ласка пароль!');
          end if;
        else
            for c in (select proxy
                        from proxy_users
                       where client = l_usrlogname)
            loop
                execute immediate 'alter user ' || l_usrlogname || ' revoke connect through ' || c.proxy;
            end loop;
        end if;

        -- Устанавливаем профиль
        if (p_recprof is not null) then
            execute immediate 'alter user ' || l_usrlogname || ' profile ' || p_recprof;
        end if;

        -- Устанавливаем умолчательную роль
        if (p_recdefrole is not null) then
            execute immediate 'grant ' || p_recdefrole || ' to ' || l_usrlogname;
            execute immediate 'alter user ' || l_usrlogname || ' default role ' || p_recdefrole;
        end if;

        if (p_usrusegtw = 1) then
          if (p_usrtabn is not null) then
           -- tabn не пустий - оновлюємо в sec_logins
             update sec_logins set secid = p_usrtabn where oralogin = l_usrlogname and taskid=1;
           -- нічого немає - вставляємо запис
            if sql%rowcount=0 then
             insert into sec_logins(secid, taskid, oralogin, orapassword) values(p_usrtabn, 1, l_usrlogname, p_recpasswd);
            end if;
            bars_audit.trace('%s: user gateway login parameters stored.', p);
          else
             -- якщо табельний номер пустий то видаляємо з таблиці шлюза
            delete from sec_logins where oralogin = l_usrlogname;
          end if;
        end if;


        --
        -- Обновление пароля при использовании шлюза
        --
        --  if nvl(p_gateway, 0) = 1 then
        --    l_str :=
        --      'update sec_logins set
        --         secid       = ''' || p_tabn     || ''',
        --          orapassword = ''' || p_password || '''
        --       where oralogin = ''' || p_login    || '''';
        --    execute immediate l_str;
        --  end if;
        --

    end alter_user;


    -----------------------------------------------------------------
    -- DROP_USER()
    --
    --     Процедура для удаления пользователя комплекса
    --
    --
    --
    procedure drop_user(
       p_userid    in  staff$base.id%type )
    is

    l_usrlogname staff$base.logname%type;    /*       имя учетной записи в БД */
    l_cnt        number;                     /*       признак налич. таблицы  */
    l_skiplic    params.val%type;            /* парам.: не вып. пересчет лиц. */

    begin
        bars_audit.trace('useradm.usrdrp: entry point par[0]=>%s', to_char(p_userid));

        -- получаем имя учетной записи
        begin
            select logname into l_usrlogname
              from staff$base
             where id = p_userid;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'USER_NOT_FOUND', to_char(p_userid));
        end;

        -- Проверяем чтобы не удалили наши схемы
        if (l_usrlogname in ('BARS', 'HIST', 'FINMON')) then
            bars_error.raise_nerror(MODCODE, 'CANT_DELETE_SPECIAL_USER', l_usrlogname);
        end if;

        -- удаление основных ресурсов
        bars_audit.trace('useradm.rmusr: deleting from resources...');
        for c in (select l.res_tabname, l.res_usercol
                    from sec_resources b, sec_resources l
                   where b.res_code = 'USER'
                     and b.res_id   = l.res_parentid)
        loop
            bars_audit.trace('useradm.rmusr: deleting from table %s (%s)...', c.res_tabname, c.res_usercol);

            select count(*) into l_cnt
              from user_tab_columns
             where table_name  = c.res_tabname
               and column_name = c.res_usercol;

            if (l_cnt > 0) then
                execute immediate 'delete from ' || c.res_tabname || ' where ' || c.res_usercol || ' = :user_id'
                using p_userid;
                bars_audit.trace('useradm.rmusr: delete from table %s (%s) completed.', c.res_tabname, c.res_usercol);
            else
                bars_audit.trace('useradm.rmusr: deleting from table %s (%s) skipped because table or column not exists', c.res_tabname, c.res_usercol);
            end if;
        end loop;
        bars_audit.trace('useradm.rmusr: delete resources completed.');


        -- удаление из дополнительных ресурсов
        bars_audit.trace('useradm.rmusr: deleting from additional resources...');
        for c in (select addres_tabname, addres_usercol
                    from staff_addresource
                  order by addres_id )
        loop
            bars_audit.trace('useradm.rmusr: deleting from table %s (%s)...', c.addres_tabname, c.addres_usercol);

            select count(*) into l_cnt
              from user_tab_columns
             where table_name  = c.addres_tabname
               and column_name = c.addres_usercol;

            if (l_cnt > 0) then
                execute immediate 'delete from ' || c.addres_tabname || ' where ' || c.addres_usercol || ' = :user_id'
                using p_userid;
                bars_audit.trace('useradm.rmusr: deleting from table %s (%s) completed.', c.addres_tabname, c.addres_usercol);
            else
                bars_audit.trace('useradm.rmusr: deleting from table %s (%s) skipped because table or column not exists', c.addres_tabname, c.addres_usercol);
            end if;
        end loop;
        bars_audit.trace('useradm.rmusr: deleting from additional resources completed.');

        -- Если отклоняем запрос на создание
        delete from staff_storage
         where id = p_userid;

        begin
            execute immediate 'drop user "' || l_usrlogname || '" cascade';
            bars_audit.trace('useradm.rmusr: user account in db removed.');
        exception
            when OTHERS then
                if (sqlcode = -1918) then
                    bars_audit.trace('useradm.rmusr: user account in db already removed');
                else raise;
                end if;
        end;

        -- устанавливаем признак удаления
        update staff$base
           set active = USER_STATE_DELETED
         where id = p_userid;
        bars_audit.trace('useradm.rmusr: user state is set (deleted).');
        -- Видаляємо з sec_logins
        delete from sec_logins where oralogin = l_usrlogname;

        bars_lic.set_user_license(l_usrlogname);
        bars_audit.trace('useradm.rmusr: user license revoked.');
        commit;

        bars_audit.security(bars_msg.get_msg(MODCODE, 'USER_ACCOUNT_DELETED', l_usrlogname));

        --
        -- выполняем обновление лицензионной инф. пользователей
        -- (в это время временные учетные записи могут стать постоянными)
        --
        l_skiplic := get_param(PARAM_SKIPLIC);

        if (l_skiplic is not null and l_skiplic = PARAMV_SKIPLIC) then
            bars_audit.trace('useradm.rmusr: skip lic rvld.');
        else
            bars_audit.trace('useradm.rmusr: revalidate usr lics ...');
            bars_lic.revalidate_lic;
            bars_audit.trace('useradm.rmusr: revalidate usr lics completed.');
        end if;


        bars_audit.trace('useradm.rmusr: succ end');

    end drop_user;

    -----------------------------------------------------------------
    -- DROP_USER_novalidate()
    --
    --     Процедура для удаления пользователя комплекса (novalidate)
    --
    --
    --
    procedure drop_user_novalidate(
       p_userid    in  staff$base.id%type )
    is

    l_usrlogname staff$base.logname%type;    /*       имя учетной записи в БД */
    l_cnt        number;                     /*       признак налич. таблицы  */
    l_skiplic    params.val%type;            /* парам.: не вып. пересчет лиц. */

    begin
        bars_audit.trace('useradm.usrdrp: entry point par[0]=>%s', to_char(p_userid));

        -- получаем имя учетной записи
        begin
            select logname into l_usrlogname
              from staff$base
             where id = p_userid;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'USER_NOT_FOUND', to_char(p_userid));
        end;

        -- Проверяем чтобы не удалили наши схемы
        if (l_usrlogname in ('BARS', 'HIST', 'FINMON')) then
            bars_error.raise_nerror(MODCODE, 'CANT_DELETE_SPECIAL_USER', l_usrlogname);
        end if;

        -- удаление основных ресурсов
        bars_audit.trace('useradm.rmusr: deleting from resources...');
        for c in (select l.res_tabname, l.res_usercol
                    from sec_resources b, sec_resources l
                   where b.res_code = 'USER'
                     and b.res_id   = l.res_parentid)
        loop
            bars_audit.trace('useradm.rmusr: deleting from table %s (%s)...', c.res_tabname, c.res_usercol);

            select count(*) into l_cnt
              from user_tab_columns
             where table_name  = c.res_tabname
               and column_name = c.res_usercol;

            if (l_cnt > 0) then
                execute immediate 'delete from ' || c.res_tabname || ' where ' || c.res_usercol || ' = :user_id'
                using p_userid;
                bars_audit.trace('useradm.rmusr: delete from table %s (%s) completed.', c.res_tabname, c.res_usercol);
            else
                bars_audit.trace('useradm.rmusr: deleting from table %s (%s) skipped because table or column not exists', c.res_tabname, c.res_usercol);
            end if;
        end loop;
        bars_audit.trace('useradm.rmusr: delete resources completed.');


        -- удаление из дополнительных ресурсов
        bars_audit.trace('useradm.rmusr: deleting from additional resources...');
        for c in (select addres_tabname, addres_usercol
                    from staff_addresource
                  order by addres_id )
        loop
            bars_audit.trace('useradm.rmusr: deleting from table %s (%s)...', c.addres_tabname, c.addres_usercol);

            select count(*) into l_cnt
              from user_tab_columns
             where table_name  = c.addres_tabname
               and column_name = c.addres_usercol;

            if (l_cnt > 0) then
                execute immediate 'delete from ' || c.addres_tabname || ' where ' || c.addres_usercol || ' = :user_id'
                using p_userid;
                bars_audit.trace('useradm.rmusr: deleting from table %s (%s) completed.', c.addres_tabname, c.addres_usercol);
            else
                bars_audit.trace('useradm.rmusr: deleting from table %s (%s) skipped because table or column not exists', c.addres_tabname, c.addres_usercol);
            end if;
        end loop;
        bars_audit.trace('useradm.rmusr: deleting from additional resources completed.');

        -- Если отклоняем запрос на создание
        delete from staff_storage
         where id = p_userid;

        begin
            execute immediate 'drop user "' || l_usrlogname || '" cascade';
            bars_audit.trace('useradm.rmusr: user account in db removed.');
        exception
            when OTHERS then
                if (sqlcode = -1918) then
                    bars_audit.trace('useradm.rmusr: user account in db already removed');
                else raise;
                end if;
        end;

        -- устанавливаем признак удаления
        update staff$base
           set active = USER_STATE_DELETED
         where id = p_userid;
        bars_audit.trace('useradm.rmusr: user state is set (deleted).');

        bars_lic.set_user_license(l_usrlogname);
        bars_audit.trace('useradm.rmusr: user license revoked.');
        commit;

        bars_audit.security(bars_msg.get_msg(MODCODE, 'USER_ACCOUNT_DELETED', l_usrlogname));

        --
        -- выполняем обновление лицензионной инф. пользователей
        -- (в это время временные учетные записи могут стать постоянными)
        --
        l_skiplic := get_param(PARAM_SKIPLIC);

        if (l_skiplic is not null and l_skiplic = PARAMV_SKIPLIC) then
            bars_audit.trace('useradm.rmusr: skip lic rvld.');
        else
            bars_audit.trace('useradm.rmusr: revalidate usr lics ...');
-- NONONO   bars_lic.revalidate_lic;
            bars_audit.trace('useradm.rmusr: revalidate usr lics completed.');
        end if;


        bars_audit.trace('useradm.rmusr: succ end');

    end drop_user_novalidate;

    --------------------------------------------------------
    -- CLONE_USER()
    --
    --     Процедура для клонирования пользователей
    --
    --
    --
    procedure clone_user(
        p_srcUserId  in  staff$base.id%type,
        p_dstUserId  in  staff$base.id%type,
        p_reslist    in  t_numberlist,
        p_resclone   in  t_numberlist,
        p_resclean   in  t_numberlist      )
    is

    p           constant varchar2(100)  := 'useradm.cloneusr';

    RES_CLONE   constant number(1)      := 1;
    RES_CLEAN   constant number(1)      := 1;

    l_tabname     sec_resources.res_tabname%type;  /*             имя таблицы ресурса */
    l_usercol     sec_resources.res_usercol%type;  /*        имя столбца с ид. польз. */
    l_resaprstate sec_resources.res_approve%type;  /* признак подтверждаемого ресурса */
    l_resviewname sec_resources.res_grntviewname%type; /* */

    l_pkcol       varchar2(2000);
    l_tabcol      varchar2(2000);
    l_stmt        varchar2(4000);
    l_resapprove  number;
    l_resaproc    varchar2(90);

    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s...', p);

        if (nvl(to_number(get_param(PARAM_LOSEC)), 0) = PARAMV_LOSEC) then
            l_resapprove := USER_APPROVED;
        else
            l_resapprove := USER_NOTAPPROVED;
        end if;
        bars_audit.trace('%s: auto approve is %s', p, to_char(l_resapprove));

        -- Проходим по списку ресурсов
        for i in 1..p_reslist.count
        loop
            bars_audit.trace('%s: processing resource %s', p, to_char(p_reslist(i)));

            -- проверяем параметр необходимости клонирования ресурса
            if (p_resclone(i) = RES_CLONE) then

                -- получаем имя таблицы и имя колонки ид. пользователя, признак подтверждаемости
                begin
                    select res_tabname, res_usercol, res_approve, res_grntviewname, res_afterproc
                      into l_tabname, l_usercol, l_resaprstate, l_resviewname, l_resaproc
                      from sec_resources
                     where res_id = p_reslist(i);
                end;
                bars_audit.trace('%s: res table %s, user col %s, approve is %s', p, l_tabname, l_usercol, l_resaprstate);

                -- Очищаем
                if (p_resclean(i) = RES_CLEAN) then
                    execute immediate 'delete from ' || l_tabname || ' where ' || l_usercol || ' = :userid'
                    using p_dstuserid;
                    bars_audit.trace('%s: all user resources for this type deleted.', p);
                else

                    -- из БМД получаем первичный ключ представления
                    l_pkcol := null;
                    for c in (select colname
                                from meta_columns c, meta_tables t
                               where t.tabname = l_resviewname
                                 and t.tabid   = c.tabid
                                 and c.showretval = 1)
                    loop
                        l_pkcol := l_pkcol || ', ' || c.colname;
                    end loop;

                    l_pkcol := substr(l_pkcol, 2);
                    bars_audit.trace('%s: resource table pk is %s', p, l_pkcol);

                    l_stmt := 'delete from ' || l_tabname || ' where ' || l_usercol || ' = :dstuserid and  ('
                              || l_pkcol || ') in (select ' || l_pkcol || ' from ' || l_tabname ||
                              ' where ' || l_usercol || ' = :srcuserid)';
                    bars_audit.trace('%s: clean res stmt is %s', p, l_stmt);

                    execute immediate l_stmt using p_dstuserid, p_srcuserid;
                    bars_audit.trace('%s: resource cleaned.', p);

                end if;

                -- Получаем список столбцов
                l_tabcol := null;
                for c in (select column_name
                            from user_tab_columns
                           where table_name   = l_tabname
                             and column_name != l_usercol
                             and column_name not in ('APPROVE', 'GRANTOR', 'BRANCH'))
                loop
                    l_tabcol := l_tabcol || ',' || c.column_name;
                end loop;
                bars_audit.trace('%s: table cols %s',p, l_tabcol);

                -- Формируем запрос
                l_stmt := 'insert into ' || l_tabname || '(' || l_usercol || l_tabcol;
                if (l_resaprstate = RESOURCE_APPROVED) then
                    l_stmt := l_stmt || ', approve, grantor';
                end if;

                l_stmt := l_stmt || ') select :dstuserid ' || l_tabcol;
                if (l_resaprstate = RESOURCE_APPROVED) then
                    l_stmt := l_stmt || ', :approve, :grantor';
                end if;

                l_stmt := l_stmt || ' from ' || l_tabname || ' where ' || l_usercol || ' = :srcuserid';
                bars_audit.trace('%s: clone stmt is %s', p, l_stmt);

                if (l_resaprstate = RESOURCE_APPROVED) then
                    execute immediate l_stmt
                    using p_dstuserid, l_resapprove, user_id, p_srcuserid;
                else
                    execute immediate l_stmt
                    using p_dstuserid, p_srcuserid;
                end if;
                bars_audit.trace('%s: clone stmt executed.', p);

                -- Выполняем пост-процедуру
                if (l_resaproc is not null) then
                    execute immediate 'begin ' || l_resaproc || '(:user_id); end;'
                    using p_dstuserid;
                end if;

            else
                bars_audit.trace('%s: resource %s skipped', p, to_char(p_reslist(i)));
            end if;

        end loop;

        -- формируем сообщение
        if (l_resapprove = USER_APPROVED) then
            g_lastmsg := bars_msg.get_msg(MODCODE, 'RESOURCE_NEED_APPROVE');
        else
            g_lastmsg := null;
        end if;

        bars_audit.trace('%s: succ end', p);

    end clone_user;


    -----------------------------------------------------------------
    -- RECREATE_USER()
    --
    --     Процедура пересоздания пользователя комплекса
    --
    --
    --
    --
    procedure recreate_user(
                  p_usrid       in  staff$base.id%type,
                  p_recpasswd   in  varchar2,
                  p_recappauth  in  varchar2,
                  p_recprof     in  varchar2,
                  p_recdefrole  in  varchar2,
                  p_recrsgrp    in  varchar2   )
    is

    p          constant varchar2(30) := 'useradm.rcrusr';

    l_usrapprove  staff$base.approve%type;  /*                         признак подтверждения */
    l_usrdefts    varchar2(30);             /* умолчательное табл. пространство пользователя */
    l_usrtmpts    varchar2(30);             /* временное табличное пространство пользователя */

    l_gtwtaskid   number := 1;
    l_gtwpasswd   varchar2(128);
    l_licpermfree number;                 /*                   кол-во неиспольз. лицензий */
    l_lictempfree number;                 /*         кол-во неиспольз. временных лицензий */

    l_reclicexp   date;                   /*       срок действия временной учетной записи */
    l_reclickey   staff$base.chksum%type; /*               лицензионный ключ пользователя */

    l_gtwuserid   number;                 /*                       ид. пользователя шлюза */
    l_cnt         number;                 /*                               просто счетчик */

    l_usrstmtcr   varchar2(4000);         /*           выражение на создание пользователя */

    l_usrstate    staff$base.active%type; /*              признак активности пользователя */
    l_usrexpdate  staff$base.expired%type;/*               срок действия временной записи */
    l_usrlogname  staff$base.logname%type;/*              имя учетной записи пользователя */
    l_usrusegtw   staff$base.usegtw%type; /*                       признак использ. шлюза */
    l_usrbranch   staff$base.branch%type; /*                   код отделения пользователя */

    begin
        bars_audit.trace('%s: entry point', p);

        -- Получаем инф. о свободных лицензиях
        bars_lic.get_user_license(l_licpermfree, l_lictempfree);
        bars_audit.trace('%s: free user licenses is %s, free temp user licenses is %s', p, to_char(l_licpermfree), to_char(l_lictempfree));

        -- если лицензий больше нет, выходим
        if (l_licpermfree = 0 and l_lictempfree = 0) then
            bars_audit.trace('%s: error detected - no licence left', p);
            bars_error.raise_nerror(MODCODE, 'USERLIMIT_EXCEED');
        end if;

        -- Получаем имена табл. пространств
        l_usrdefts := nvl(get_param('USRDEFTS'), USER_DEFTS);
        l_usrtmpts := nvl(get_param('USRTMPTS'), USER_TMPTS);
        bars_audit.trace('%s: defts=%s tmpts=%s', p, l_usrdefts, l_usrtmpts);

        -- Получаем реквизиты пользователя
        select active, expired, logname, usegtw, branch
          into l_usrstate, l_usrexpdate, l_usrlogname, l_usrusegtw, l_usrbranch
          from staff$base
         where id = p_usrid;

        -- Восстановить можно неактивную постоянную запись
        if (nvl(l_usrstate, USER_STATE_ACTIVE) != USER_STATE_DELETED or l_usrexpdate is not null) then
            bars_audit.trace('%s: error detected - user state is active or user expire date is set');
            bars_error.raise_nerror(MODCODE, 'RECREATE_INVALID_USERSTATE');
        end if;

        -- Проверяем лицензию на пользователя (невозможно проверить лицензию удаленному польз.)
        -- bars_lic.validate_lic(l_usrlogname);

        -- если будет использоваться временная лицензия, рассчитываем ключ
        if (l_licpermfree = 0) then
            l_reclicexp := sysdate + USRLIC_TEMPORARY_LIFETIME -1;
            l_reclickey := imake_tkey(p_usrid, l_usrlogname, l_reclicexp);
            bars_audit.trace('%s: user license expired date and key generated. (%s)', p, l_reclickey);
        end if;

        -- создаем пользователя

        -- Выражение на создание пользователя
        l_usrstmtcr := 'create user ' || l_usrlogname || ' identified by ' || p_recpasswd ||
                       ' default tablespace ' || l_usrdefts || ' temporary tablespace ' || l_usrtmpts;

        if (p_recprof is not null) then
            l_usrstmtcr := l_usrstmtcr || ' profile "' || p_recprof || '"';
        end if;
        bars_audit.trace('%s: database account stmt=>%s', p, l_usrstmtcr);

        if (l_usrusegtw != 1) then

            -- создаем пользователя
            execute immediate l_usrstmtcr;
            bars_audit.trace('%s: database account created.', p);

            -- даем квоту на табл. пространство
            execute immediate 'alter user ' || l_usrlogname || ' quota unlimited on ' || l_usrdefts;
            bars_audit.trace('%s: qouta granted.', p);

            -- даем право на соединение
            execute immediate 'grant create session to ' || l_usrlogname;
            bars_audit.trace('%s: create session granted.', p);

            if (p_recdefrole is not null) then
                -- выдаем умолчательную роль
                execute immediate 'grant ' || p_recdefrole || ' to ' || l_usrlogname;
                bars_audit.trace('%s: default role %s granted.', p, p_recdefrole);

                -- устанавливаем умолчат. роль
                execute immediate 'alter user ' || l_usrlogname || ' default role ' || p_recdefrole;
                bars_audit.trace('%s: default role %s is set for user.', p, p_recdefrole);
            end if;

            if (p_recappauth is not null) then
                -- разрешаем работу через proxy-пользователя
                execute immediate 'alter user ' || l_usrlogname || ' grant connect through "' || p_recappauth || '"';
                bars_audit.trace('%s: connect through %s granted to user.', p, p_recappauth);
            end if;

        end if;

        -- состояние подтверждения
        if (l_usrusegtw = 1) then
            l_usrapprove := USER_NOTAPPROVED;
        else
            l_usrapprove := USER_APPROVED;
        end if;

        -- Добавляем разрешенное отделение (TOБО)
        begin

            update staff$base
               set active  = USER_STATE_ACTIVE,
                   expired = l_reclicexp,
                   chksum  = l_reclickey
             where id = p_usrid;

            begin
                select count(*) into l_cnt
                  from staff_branch
                 where id     = p_usrid
                   and branch = l_usrbranch;

                if (l_cnt = 0) then
                    insert into staff_branch(id, branch)
                    values (p_usrid, l_usrbranch);
                end if;
            exception
                when DUP_VAL_ON_INDEX then null;
            end;
            bars_audit.trace('%s: user default branch is set', p);

            -- рассчитываем ключ
            bars_lic.set_user_license(l_usrlogname);
            bars_audit.trace('%s: user license generated.', p);
        exception
            when OTHERS then
                rollback;
                execute immediate 'drop user ' || l_usrlogname;
                raise;
        end;

        if (l_usrusegtw = 1) then
            -- сохраняем запрос на создание
            l_gtwuserid := gate_user_id;
            insert into staff_storage(id, storage_stmt, grantor, grants, roles)
            values (p_usrid, l_usrstmtcr, l_gtwuserid, p_recdefrole, p_recdefrole);
            bars_audit.trace('%s: user create statement stored.', p);
        end if;

        commit;

        -- формируем сообщение
        if (l_licpermfree = 0) then
            g_lastmsg := bars_msg.get_msg(MODCODE, 'TEMPORARY_USER_CREATED', l_usrlogname);
        else
            g_lastmsg := bars_msg.get_msg(MODCODE, 'USER_CREATED', l_usrlogname);
        end if;


        bars_audit.trace('%s: succ end', p);

    end recreate_user;


    -----------------------------------------------------------------
    -- LOCK_USER()
    --
    --     Процедура блокировки пользователя
    --
    --     Параметры:
    --
    --         p_userid       Идентификатор пользователя
    --
    --         p_begindate    Начальная дата блокировки
    --
    --         p_enddate      Конечная дата блокировки
    --
    procedure lock_user(
        p_userid    in  staff$base.id%type,
        p_begindate in  staff$base.rdate1%type default null,
        p_enddate   in  staff$base.rdate2%type default null )
    is

    l_usrlogname     staff$base.logname%type;    /*   имя учетной записи */
    l_usrdisable     staff$base.disable%type;    /*   признак блокировки */
    l_usrdisbdate    staff$base.rdate1%type;     /* нач. дата блокировки */
    l_usrdisedate    staff$base.rdate1%type;     /* кон. дата блокировки */

    begin
        bars_audit.trace('useradm.usrlock: entry point par[0]=>%s, par[1]=>%s par[2]=>%s', to_char(p_userid), to_char(p_begindate, 'ddmmyyyy'), to_char(p_enddate, 'ddmmyyyy'));

        begin
            select logname, disable, rdate1, rdate2
              into l_usrlogname, l_usrdisable, l_usrdisbdate, l_usrdisedate
              from staff$base
             where id = p_userid;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'USER_NOT_FOUND', to_char(p_userid));
        end;
        bars_audit.trace('useradm.usrlock: user req taken');

        if (p_begindate is not null or p_enddate is not null) then
            update staff$base
               set rdate1 = p_begindate,
                   rdate2 = p_enddate
             where id = p_userid;
        end if;
        bars_audit.trace('useradm.usrlock: lock data saved');

        -- Если пользователь заблокирован, блокируем учетную запись
        if (p_begindate is null and p_enddate is null) then
            execute immediate 'alter user ' || l_usrlogname || ' account lock';
            update staff$base set disable = 1 where id = p_userid;
        end if;
        bars_audit.trace('useradm.usrlock: database account locked.');


        bars_audit.security(bars_msg.get_msg(MODCODE, 'USER_ACCOUNT_LOCKED', l_usrlogname));
        bars_audit.trace('useradm.usrlock: succ end');

    end lock_user;


    -----------------------------------------------------------------
    -- UNLOCK_USER()
    --
    --     Процедура разблокировки пользователя
    --
    --     Параметры:
    --
    --         p_userid       Идентификатор пользователя
    --
    --         p_begindate    Начальная дата разблокировки
    --
    --         p_enddate      Конечная дата разблокировки
    --
    --
    procedure unlock_user(
        p_userid    in  staff$base.id%type,
        p_begindate in  staff$base.adate1%type default null,
        p_enddate   in  staff$base.adate2%type default null )
    is

    l_usrlogname     staff$base.logname%type;    /*   имя учетной записи */
    l_usrdisable     staff$base.disable%type;    /*   признак блокировки */
    l_usrenbdate     staff$base.adate1%type;     /*    нач. дата доступа */
    l_usrenedate     staff$base.adate1%type;     /*    кон. дата доступа */

    begin
        bars_audit.trace('useradm.usrunlock: entry point par[0]=>%s, par[1]=>%s par[2]=>%s', to_char(p_userid), to_char(p_begindate, 'ddmmyyyy'), to_char(p_enddate, 'ddmmyyyy'));

        begin
            select logname, disable, adate1, adate2
              into l_usrlogname, l_usrdisable, l_usrenbdate, l_usrenedate
              from staff$base
             where id = p_userid;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'USER_NOT_FOUND', p_userid);
        end;
        bars_audit.trace('useradm.usrunlock: user req taken');


        if (p_begindate is not null or p_enddate is not null) then
            update staff$base
               set adate1  = p_begindate,
                   adate2  = p_enddate
             where id = p_userid;
        end if;
        bars_audit.trace('useradm.usrunlock: unlock data saved');

        -- Разблокируем учетную запись в БД
        execute immediate 'alter user ' || l_usrlogname || ' account unlock';
        update staff$base set disable = 0 where id = p_userid;
        bars_audit.trace('useradm.usrlock: database account unlocked.');


        bars_audit.security(bars_msg.get_msg(MODCODE, 'USER_ACCOUNT_UNLOCKED', l_usrlogname));
        bars_audit.trace('useradm.usrunlock: succ end');

    end unlock_user;


    -----------------------------------------------------------------
    -- TRANSMIT_USER_ACCOUNTS()
    --
    --     Процедура передачи счетов пользователя другому
    --     пользователю
    --
    --     Параметры:
    --
    --         p_olduserid   Ид. польз., который передает счета
    --
    --         p_newuserid   Ид. польз., которому передают счета
    --
    procedure transmit_user_accounts(
        p_olduserid    in  staff$base.id%type,
        p_newuserid    in  staff$base.id%type )
    is

    l_oldusrfio  staff$base.fio%type;  /*  ФИО польз., который передает */
    l_newusrfio  staff$base.fio%type;  /* ФИО польз., которому передают */
    l_usrtype    staff$base.type%type; /*    Признак ответ. исполнителя */
    l_bankdate   fdat.fdat%type;       /*      текущая глоб. банк. дата */

    begin
        bars_audit.trace('useradm.trsusracc: entry point par[0]=>%s par[1]=>%1', to_char(p_olduserid), to_char(p_newuserid));

        -- Проверяем наличие пользователей
        validate_userid(p_olduserid);
        validate_userid(p_newuserid);

        -- Проверяем признак "Ответ. исполнитель"
        select nvl(type, 0) into l_usrtype
          from staff$base
         where id = p_newuserid;

        if (l_usrtype != USER_ACCOWN) then
            bars_error.raise_nerror(MODCODE, 'USER_NOT_ACCOWN', to_char(p_newuserid));
        end if;

        -- Получаем тек. глобальную банковскую дату
        l_bankdate := bankdate_g;

        -- Получаем ФИО пользователей
        l_oldusrfio := get_user_fio(p_olduserid);
        l_newusrfio := get_user_fio(p_newuserid);

        -- Проходим по всем не закрытым счетам
        for c in (select acc, nls, kv
                    from accounts
                   where isp = p_olduserid
                     and (dazs is null or dazs >= l_bankdate))
        loop
           update accounts
              set isp = p_newuserid
            where acc = c.acc;
           bars_audit.security(bars_msg.get_msg(MODCODE, 'TRANSFER_USER_ACCOUNT', c.nls, c.kv, l_oldusrfio, l_newusrfio));
        end loop;

        bars_audit.security(bars_msg.get_msg(MODCODE, 'TRANSFER_USER_ACCOUNTS_END', l_oldusrfio, l_newusrfio));
        bars_audit.trace('useradm.trsusracc: succ end');

    end transmit_user_accounts;


    --------------------------------------------------------
    -- ADD_USER_MBRANCH()
    --
    --     Разрешение пользователю работать с указанным
    --     псевдо-МФО
    --
    --     Параметры:
    --
    --         p_userid       Идентификатор пользователя
    --
    --         p_mfo          Псевдо-МФО
    --
    procedure add_user_mbranch(
        p_userid    in  staff$base.id%type,
        p_mfo       in  banks.mfo%type     )
    is
    begin

        bars_audit.trace('useradm.addusrmbr: entry point par[0]=>%s, par[1]=>%s', to_char(p_userid), p_mfo);


        bars_audit.security(bars_msg.get_msg(MODCODE, 'ADD_USER_MBRANCH', get_user_fio(p_userid), p_mfo));
        bars_audit.trace('useradm.addusrmbr: succ end');

    end add_user_mbranch;




    --------------------------------------------------------
    -- REMOVE_USER_MBRANCH()
    --
    --     Запрет пользователю работать с указанным
    --     псевдо-МФО
    --
    --     Параметры:
    --
    --         p_userid       Идентификатор пользователя
    --
    --         p_mfo          Псевдо-МФО
    --
    procedure remove_user_mbranch(
        p_userid    in  staff$base.id%type,
        p_mfo       in  banks.mfo%type     )
    is
    begin

        bars_audit.trace('useradm.rmusrmbr: entry point par[0]=>%s par[1]=>%s', to_char(p_userid), p_mfo);


        bars_audit.trace('useradm.rmusrmbr: succ end');

    end remove_user_mbranch;


    --------------------------------------------------------
    -- GET_USER_LICSTATE()
    --
    --     Функция получения состояния лицензии учетной
    --     записи пользователя
    --
    --     Параметры:
    --
    --         p_userid   Ид. пользователя
    --
    --
    function get_user_licstate(
       p_userid    in  staff$base.id%type ) return number
    is

    p          constant varchar2(30) := 'useradm.getusrlicst';

    l_logname  staff$base.logname%type;   /* имя учетной */
    begin

        select logname into l_logname
          from staff$base
         where id = p_userid;

        return bars_lic.get_user_licensestate(l_logname);

    end get_user_licstate;


    -----------------------------------------------------------------
    -- SET_USER_CONTEXT()
    --
    --     Процедура установки контекста для просмотра ресурсов
    --     указанного пользователя
    --
    --     Параметры:
    --
    --         p_userid    Ид. пользователя
    --
    --
    procedure set_user_context(
                  p_userid  in  staff$base.id%type)
    is
    p          constant varchar2(30) := 'useradm.setusrctx';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_userid));
        sys.dbms_session.set_context('bars_useradm', 'user_id', p_userid);
        bars_audit.trace('%s: succ end', p);
    end set_user_context;


    -----------------------------------------------------------------
    -- SET_USER_MODE()
    --
    --     Процедура установки режима работы с пользователями
    --
    --     Параметры:
    --
    --         p_mode      Код режима
    --
    --
    procedure set_user_mode(
                  p_mode    in  number )
    is
    p          constant varchar2(30) := 'useradm.setusrmode';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_mode));
        sys.dbms_session.set_context(CTX_USERADM, CTXV_CMODE, to_char(p_mode));
        bars_audit.trace('%s: succ end', p);
    end set_user_mode;


    -----------------------------------------------------------------
    -- SET_USER_MODEPARAM()
    --
    --     Процедура установки параметров текущего режима
    --
    --     Параметры:
    --
    --         p_mpname     Код параметра
    --
    --         p_mpvalue    Значение параметра
    --
    procedure set_user_modeparam(
                  p_mpname    in  varchar2,
                  p_mpvalue   in  varchar2 )
    is
    p          constant varchar2(30) := 'useradm.setusrmpar';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, p_mpname, p_mpvalue);

        if (to_number(sys_context(CTX_USERADM, CTXV_CMODE)) = USERMODE_MBRANCH) then

            if (p_mpname = USERMPAR_MBRANCH) then
                sys.dbms_session.set_context(CTX_USERADM, CTXV_CMBRANCH, p_mpvalue);
            end if;

        end if;
        bars_audit.trace('%s: succ end', p);

    end set_user_modeparam;


    --------------------------------------------------------
    -- GET_LAST_MESSAGE()
    --
    --     Функция получения сообщения функции
    --
    --
    function get_last_message return varchar2
    is
    begin
        return g_lastmsg;
    end get_last_message;


    -----------------------------------------------------------------
    -- CHECK_RESOURCE_CONDITION()
    --
    --     Функция проверки доступности ресурса
    --
    --     рБТБНЕФТЩ:
    --
    --         p_condition  Выражение
    --
    --
    function check_resource_condition(
                  p_condition    in  varchar2) return varchar2
    is
    l_result varchar2(1);  /* результат проверки */
    begin

        if (p_condition is not null) then
            execute immediate p_condition into l_result;
        else
            l_result := RESOURCE_ACTIVE;
        end if;

        return l_result;

    end check_resource_condition;


    -----------------------------------------------------------------
    -- GRANT_USER_RESOURCE()
    --
    --     Процедура выдачи ресурса пользователю
    --
    --     Параметры:
    --
    --         p_userid    Ид. пользователя
    --
    --         p_resid     Ид. ресурса
    --
    --         p_colnames  Список имен реквизитов
    --
    --         p_colvals   Список значений реквизитов
    --
    --
    procedure grant_user_resource(
                  p_userid   in  staff$base.id%type,
                  p_resid    in  sec_resources.res_id%type,
                  p_colnames in  t_varchar2list,
                  p_colvals  in  t_varchar2list             )
    is

    p            constant varchar2(100)  := 'useradm.grntusrres';

    l_resrow     t_anyrow := t_anyrow();

    l_resapprove number;   /* признак необходимости подтверждения */

    l_tabname    varchar2(30);  /* имя таблицы ресурса */
    l_usercol    varchar2(30);  /* имя колонки пользователя */

    l_stmt       varchar2(4000);/* текст запроса */

    l_cno        t_chandle;            /*              идентификатор курсора */
    l_rowcnt     number;

    l_resaprstate sec_resources.res_approve%type;  /* признак подтверждаемости ресурса */
    l_resaproc    sec_resources.res_afterproc%type; /* имя пост-процедуры */

    begin

        bars_audit.trace('useradm.grntures: entry point par[0]=>%s, par[1]=>%s par[2]=>...par[3]=>...', to_char(p_userid), to_char(p_resid));

        -- получаем имя таблицы и имя колонки ид. пользователя, признак подтверждаемости
        begin
            select res_tabname, res_usercol, res_approve, res_afterproc
              into l_tabname, l_usercol, l_resaprstate, l_resaproc
              from sec_resources
             where res_id = p_resid;
        end;
        bars_audit.trace('%s: res table %s, user col %s, apr state %s', p, l_tabname, l_usercol, l_resaprstate);

        -- конвертируем параметры во внутренюю структуру
        icnv_cols(p_resid, p_colnames, p_colvals, l_resrow);
        bars_audit.trace('%s: parameters converted to int storage', p);

        -- получаем признак автоподтверждения
        if (l_resaprstate = RESOURCE_APPROVED) then

            if (nvl(to_number(get_param(PARAM_LOSEC)), 0) = PARAMV_LOSEC) then
                l_resapprove := USER_APPROVED;
            else
                l_resapprove := USER_NOTAPPROVED;
            end if;
            bars_audit.trace('%s: auto approve is %s', p, to_char(l_resapprove));

        end if;

        -- Формируем запрос на вставку
        l_stmt := 'insert into ' || l_tabname || '(' || l_usercol || ', ';

        if (l_resaprstate = RESOURCE_APPROVED) then
            l_stmt := l_stmt || 'approve, grantor, ';
        end if;

        l_stmt := l_stmt || isvc_coltab2list(l_resrow) || ')' || ' values (:userid, ';

        if (l_resaprstate = RESOURCE_APPROVED) then
            l_stmt := l_stmt || ':approve, :grantor, ';
        end if;

        l_stmt := l_stmt || isvc_coltab2list(l_resrow, ':') || ')';
        bars_audit.trace('%s: res grant stmt is %s', p, l_stmt);

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        dbms_sql.bind_variable(l_cno, 'userid',  p_userid);

        if (l_resaprstate = RESOURCE_APPROVED) then
            dbms_sql.bind_variable(l_cno, 'approve', l_resapprove);
            dbms_sql.bind_variable(l_cno, 'grantor', user_id);
        end if;

        isvc_cbind(l_cno, l_resrow);

        -- Выполняем
        bars_audit.trace('%s: inserting resource...', p);
        begin
            l_rowcnt := dbms_sql.execute(l_cno);
        exception when dup_val_on_index then null;
        end;
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row inserted.', p, to_char(l_rowcnt));

        -- Выполняем пост-процедуру
        if (l_resaproc is not null) then
            execute immediate 'begin ' || l_resaproc || '(:user_id); end;'
            using p_userid;
        end if;


        if (l_resaprstate = RESOURCE_APPROVED and l_resapprove = USER_NOTAPPROVED) then
            --
            g_lastmsg := bars_msg.get_msg(MODCODE, 'RESOURCE_NEED_APPROVE');
        else
            g_lastmsg := null;
        end if;

        bars_audit.security('Выдан ресурс пользователю');
        bars_audit.trace('%s: succ end', p);

    end grant_user_resource;



    -----------------------------------------------------------------
    -- GRANT_USER_ATTRIBUTE()
    --
    --     Процедура выдачи для подтверждения атрибутов пользователя
    --
    --     Параметры:
    --
    --         p_userid     Ид. пользователя
    --
    --         p_attrnames  Список имен атрибутов
    --
    --         p_attrvals   Список значений атрибутов
    --
    --
    procedure grant_user_attribute(
                  p_userid    in  staff$base.id%type,
                  p_attrnames in  t_varchar2list,
                  p_attrvals  in  t_varchar2list             )
    is

    p            constant varchar2(100)  := 'useradm.grntusrattr';

    l_resrow     t_anyrow := t_anyrow();

    l_tabname    varchar2(30);  /* имя таблицы ресурса */
    l_usercol    varchar2(30);  /* имя колонки пользователя */
    l_storage    varchar2(30);  /* имятаблицы-хранилища атрибута */

    l_stmt       varchar2(4000);/* текст запроса */

    l_cno        t_chandle;     /* идентификатор курсора */
    l_rowcnt     number;

    begin

        bars_audit.trace('%s: entry point par[0]=>%s, par[1]=>... par[2]=>...', p, to_char(p_userid));

        for i in 1..p_attrnames.count
        loop

            l_resrow.extend;
            l_resrow(i).column_name := p_attrnames(i);

            select attr_tabname, attr_usercol, attr_storage
              into l_tabname, l_usercol, l_storage
              from sec_attributes
             where attr_code = p_attrnames(i);

            select data_type, data_length
              into l_resrow(i).column_type, l_resrow(i).column_size
              from user_tab_columns
             where table_name = l_tabname
               and column_name = p_attrnames(i);

            case
                when (l_resrow(i).column_type = 'VARCHAR2') then
                    l_resrow(i).column_data := anydata.convertvarchar(p_attrvals(i));
                when (l_resrow(i).column_type = 'CHAR') then
                    l_resrow(i).column_data := anydata.convertvarchar(p_attrvals(i));
                when (l_resrow(i).column_type = 'NUMBER') then
                    l_resrow(i).column_data := anydata.convertnumber(to_number(p_attrvals(i)));
                when (l_resrow(i).column_type = 'DATE') then
                    l_resrow(i).column_data := anydata.convertdate(to_date(p_attrvals(i), 'dd.mm.yyyy hh24:mi:ss'));
                else
                    bars_error.raise_nerror(MODCODE, 'UNSUPPORTED_RESOURCE_DATATYPE');
            end case;

            -- Формируем запрос на удаление
            l_stmt := 'delete from ' || l_tabname || ' where ' || l_usercol || '=:userid';

            l_cno := isvc_cprep(l_stmt);

            -- Привязываем переменные
            dbms_sql.bind_variable(l_cno, 'userid',  p_userid);

            -- Выполняем
            l_rowcnt := dbms_sql.execute(l_cno);
            dbms_sql.close_cursor(l_cno);

            -- Формируем запрос на вставку
            l_stmt := 'insert into ' || l_tabname || '(' || l_usercol || ', ';
            l_stmt := l_stmt || isvc_coltab2list(l_resrow) || ', grantor) values (:userid, ';
            l_stmt := l_stmt || isvc_coltab2list(l_resrow, ':') || ', :grantor)';
            bars_audit.trace('%s: attr grant stmt is %s', p, l_stmt);

            l_cno := isvc_cprep(l_stmt);

            -- Привязываем переменные
            dbms_sql.bind_variable(l_cno, 'userid',  p_userid);
            dbms_sql.bind_variable(l_cno, 'grantor', user_id);

            isvc_cbind(l_cno, l_resrow);

            -- Выполняем
            bars_audit.trace('%s: inserting attribute...', p);
            l_rowcnt := dbms_sql.execute(l_cno);
            dbms_sql.close_cursor(l_cno);
            bars_audit.trace('%s: %s row inserted.', p, to_char(l_rowcnt));

        end loop;

        bars_audit.security('Выданы для подтверждения атрибуты пользователя');
        bars_audit.trace('%s: succ end', p);

    end grant_user_attribute;


    -----------------------------------------------------------------
    -- ALTER_USER_ATTRIBUTE()
    --
    --     Процедура подтверждения изменения атрибутов пользователя
    --
    --     Параметры:
    --
    --         p_userid     Ид. пользователя
    --
    --         p_attrid     Ид. атрибута
    --
    --
    procedure alter_user_attribute(
                  p_userid  in  staff$base.id%type,
                  p_attrid  in  sec_attributes.attr_id%type  )
    is

    p            constant varchar2(100)  := 'useradm.altusrattr';

    l_resrow     t_anyrow := t_anyrow();

    l_code       sec_attributes.attr_code%type;
    l_tabname    sec_attributes.attr_tabname%type;
    l_usercol    sec_attributes.attr_usercol%type;
    l_storage    sec_attributes.attr_storage%type;

    l_stmt       varchar2(4000);/* текст запроса */

    l_cno        t_chandle;     /* идентификатор курсора */
    l_rowcnt     number;

    begin

        bars_audit.trace('%s: entry point par[0]=>%s, par[1]=>%s', p, to_char(p_userid), to_char(p_attrid));

        select attr_code, attr_tabname, attr_usercol, attr_storage
          into l_code, l_tabname, l_usercol, l_storage
          from sec_attributes
         where attr_id = p_attrid;

        -- Формируем запрос на обновление
        l_stmt := 'update ' || l_storage || ' set ' ||
                   l_code || ' = (select ' || l_code || ' from ' || l_tabname || ' where ' || l_usercol || ' = :userid)' ||
                  'where ' || l_usercol || ' = :userid';
        bars_audit.trace('%s: attr alter stmt is %s', p, l_stmt);

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        dbms_sql.bind_variable(l_cno, 'userid',  p_userid);

        isvc_cbind(l_cno, l_resrow);

        -- Выполняем
        bars_audit.trace('%s: updating attribute...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row updated.', p, to_char(l_rowcnt));

        drop_user_attribute(p_userid, p_attrid);

    end alter_user_attribute;


    -----------------------------------------------------------------
    -- DROP_USER_ATTRIBUTE()
    --
    --     Процедура удаления атрибута пользователя
    --
    --     Параметры:
    --
    --         p_userid     Ид. пользователя
    --
    --         p_attrid     Ид. атрибута
    --
    --
    procedure drop_user_attribute(
                  p_userid  in  staff$base.id%type,
                  p_attrid  in  sec_attributes.attr_id%type  )
    is

    p            constant varchar2(100)  := 'useradm.delusrattr';

    l_resrow     t_anyrow := t_anyrow();

    l_tabname    sec_attributes.attr_tabname%type;
    l_usercol    sec_attributes.attr_usercol%type;

    l_stmt       varchar2(4000);/* текст запроса */

    l_cno        t_chandle;     /* идентификатор курсора */
    l_rowcnt     number;

    begin

        bars_audit.trace('%s: entry point par[0]=>%s, par[1]=>%s', p, to_char(p_userid), to_char(p_attrid));

        select attr_tabname, attr_usercol
          into l_tabname, l_usercol
          from sec_attributes
         where attr_id = p_attrid;

        -- Формируем запрос на удаление
        l_stmt := 'delete from ' || l_tabname ||
                  ' where ' || l_usercol || ' = :userid';
        bars_audit.trace('%s: attr del stmt is %s', p, l_stmt);

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        dbms_sql.bind_variable(l_cno, 'userid',  p_userid);

        isvc_cbind(l_cno, l_resrow);

        -- Выполняем
        bars_audit.trace('%s: deleting attribute...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row deleted.', p, to_char(l_rowcnt));

    end drop_user_attribute;


    -----------------------------------------------------------------
    --  NEED_CHECK_GRANTOR()
    --
    --     Функция для определения необходимости проверки грантора
    --     (если меняется approve - проверка нужна,
    --      если меняются другие параметры - проверка не нужна)
    --
    --     Параметры:
    --
    --         p_colnames   Список имен изменяемых реквизитов
    --
    function need_check_grantor (p_colnames in t_varchar2list ) return boolean
    is
      l_ret boolean := false;
    begin
        for i in 1..p_colnames.count
        loop

            if lower(p_colnames(i)) = 'approve' then
               l_ret := true;
               exit;
            end if;

        end loop;

        return l_ret;

    end need_check_grantor;


    -----------------------------------------------------------------
    --  CHECK_GRANTOR()
    --
    --     Проверка кода грантора ресурса для пользователя. (Данный код не должен совпадать с кодом
    --     безопасника, который подтверждает/аннулирует ресурс
    --
    --     Параметры:
    --
    --         p_tablename  Имя таблицы ресурса
    --
    --         p_usercol    Имя колонки таблицы ресурса (суть код пользователя)
    --
    --         p_respkrow   Список колонок на условие where для поска записи в таблице ресурса
    --
    --         p_resid      Код пользоватля(АРМ-а) которому выдписок колонок на условие where для поска записи в таблице ресурса
    --
    procedure check_grantor(
                  p_tablename  in  varchar2,
                  p_usercol    in  varchar2,
                  p_respkrow   in  t_anyrow,
                  p_resid      in  varchar2)
    is
       l_cno        number;                     /*  идентификатор курсора */
       l_stmt       varchar2(4000);             /*  текст запроса */
       l_grantor    number(38)  default null;   /*  код грантора */
       l_rowcnt     number;
       p            constant varchar2(100)  := 'useradm.chkgrantor';
    begin

        if user_name <> 'BARS' then

            -- проверка грантора ресурса (визирь не должен быть грантором)
            l_stmt := 'select grantor from '||p_tablename ||
                      ' where ' || p_usercol || ' = :resid and ' || isvc_coltab2pair(p_respkrow, ' and ');
            l_cno := isvc_cprep(l_stmt);
            -- Привязываем переменные
            dbms_sql.bind_variable(l_cno, 'resid',  p_resid);
            isvc_cbind(l_cno, p_respkrow);
            dbms_sql.define_column (c        => l_cno,
                                    position => 1,
                                    column   => l_grantor);

            l_rowcnt := dbms_sql.execute(l_cno);

            if (dbms_sql.fetch_rows(c => l_cno) > 0) then
                dbms_sql.column_value(c        => l_cno,
                                      position => 1,
                                         value => l_grantor);
            end if;
            dbms_sql.close_cursor(l_cno);
            bars_audit.trace('%s: grantor code %d', p, to_char(l_grantor));

            if l_grantor = user_id then
               bars_error.raise_nerror(MODCODE, 'NOTPERMITED_WITH_THIS_USER');
            end if;

       end if;

    end check_grantor;


    -----------------------------------------------------------------
    -- REVOKE_USER_RESOURCE()
    --
    --     Процедура отзыва ресурса у пользователя
    --
    --     Параметры:
    --
    --         p_userid    Ид. пользователя
    --
    --         p_resid     Ид. ресурса
    --
    --         p_colnames  Список имен реквизитов
    --
    --         p_colvals   Список значений реквизитов
    --
    --
    procedure revoke_user_resource(
                  p_userid   in  staff$base.id%type,
                  p_resid    in  sec_resources.res_id%type,
                  p_colnames in  t_varchar2list,
                  p_colvals  in  t_varchar2list             )
    is
    p            constant varchar2(100)  := 'useradm.revusrres';

    l_resrow     t_anyrow := t_anyrow();

    l_resapprove number;   /* признак необходимости подтверждения */

    l_tabname    varchar2(30);  /* имя таблицы ресурса */
    l_usercol    varchar2(30);  /* имя колонки пользователя */

    l_stmt       varchar2(4000);/* текст запроса */

    l_cno        t_chandle;            /*              идентификатор курсора */
    l_rowcnt     number;

    l_resstate   number;

    l_resaprstate sec_resources.res_approve%type;  /* признак подтверждаемости ресурса */
    l_resaproc    sec_resources.res_afterproc%type; /* имя пост-процедуры */

    begin

        bars_audit.trace('useradm.revusrres: entry point par[0]=>%s, par[1]=>%s par[2]=>...par[3]=>...', to_char(p_userid), to_char(p_resid));

        -- получаем имя таблицы и имя колонки ид. пользователя, признак подтверждаемости
        begin
            select res_tabname, res_usercol, res_approve, res_afterproc
              into l_tabname, l_usercol, l_resaprstate, l_resaproc
              from sec_resources
             where res_id = p_resid;
        end;
        bars_audit.trace('%s: res table %s, user col %s, apr state %s', p, l_tabname, l_usercol, l_resaprstate);

        -- конвертируем параметры во внутренюю структуру
        icnv_cols(p_resid, p_colnames, p_colvals, l_resrow);
        bars_audit.trace('%s: parameters converted to int storage', p);

        -- получаем признак автоподтверждения
        if (l_resaprstate = RESOURCE_APPROVED) then

            if (nvl(to_number(get_param(PARAM_LOSEC)), 0) = PARAMV_LOSEC) then
                l_resapprove := USER_NOTAPPROVED;
            else
                l_resapprove := USER_APPROVED;
            end if;
            bars_audit.trace('%s: auto approve is %s', p, to_char(l_resapprove));

        end if;

    -- получаем признак автоподтверждения
        if (l_resaprstate = RESOURCE_APPROVED) then

            -- получаем значение поля approve
            l_stmt := 'select approve from ' || l_tabname || ' where ' || l_usercol || ' = :userid and ' ||
                      isvc_coltab2pair(l_resrow, ' and ');
            bars_audit.trace('%s: get approve stmt is %s', p, l_stmt);

            l_cno := isvc_cprep(l_stmt);

            -- Привязываем переменные
            dbms_sql.bind_variable(l_cno, 'userid',  p_userid);
            isvc_cbind(l_cno, l_resrow);

            -- определяем возвращаемый столбец
            dbms_sql.define_column(l_cno, 1, l_resstate);

            -- Выполняем
            bars_audit.trace('%s: executing statement...', p);
            l_rowcnt := dbms_sql.execute_and_fetch(l_cno);

            -- Получаем значение
            dbms_sql.column_value(l_cno, 1, l_resstate);
            bars_audit.trace('%s: approve for row is %s', p, to_char(l_resstate));
            dbms_sql.close_cursor(l_cno);

        end if;

        if (l_resaprstate = RESOURCE_APPROVED and l_resapprove = USER_APPROVED and l_resstate = USER_APPROVED) then

        -- ставим признак отозванного
            l_stmt := 'update ' || l_tabname || ' set revoked = 1, grantor = user_id where '  || l_usercol || ' = :userid and ' ||
                      isvc_coltab2pair(l_resrow, ' and ');
            bars_audit.trace('%s: revoke stmt is %s', p, l_stmt);

            -- формируем сообщение
            g_lastmsg := bars_msg.get_msg(MODCODE, 'RESOURCE_NEED_APPROVE');

        else
            -- сразу удаляем
            l_stmt := 'delete from ' || l_tabname || ' where '  || l_usercol || ' = :userid and ' ||
                      isvc_coltab2pair(l_resrow, ' and ');
            bars_audit.trace('%s: revoke stmt is %s', p, l_stmt);

            -- сообщение не требуется
            g_lastmsg := null;

        end if;

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        dbms_sql.bind_variable(l_cno, 'userid',  p_userid);
        isvc_cbind(l_cno, l_resrow);

        -- Выполняем
        bars_audit.trace('%s: revoking resource...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row deleted.', p, to_char(l_rowcnt));

        -- Выполняем пост-процедуру
        if (l_resaproc is not null) then
            execute immediate 'begin ' || l_resaproc || '(:user_id); end;'
            using p_userid;
        end if;

        bars_audit.security('Ресурс пользователя отозван');
        bars_audit.trace('%s: succ end', p);

    end revoke_user_resource;



    -----------------------------------------------------------------
    -- ALTER_USER_RESOURCE()
    --
    --     Процедура изменения параметров ресурса у пользователя
    --
    --     Параметры:
    --
    --         p_userid     Ид. пользователя
    --
    --         p_resid      Ид. ресурса
    --
    --         p_pkcolnames Список имен столбцов перв. ключа
    --
    --         p_pkcolvals  Список значений столбцов перв. ключа
    --
    --         p_colnames   Список имен изменяемых реквизитов
    --
    --         p_colvals    Список значений изменяемых реквизитов
    --
    --
    procedure alter_user_resource(
                  p_userid     in  staff$base.id%type,
                  p_resid      in  sec_resources.res_id%type,
                  p_pkcolnames in  t_varchar2list,
                  p_pkcolvals  in  t_varchar2list,
                  p_colnames   in  t_varchar2list,
                  p_colvals    in  t_varchar2list             )
    is

    p            constant varchar2(100)  := 'useradm.revusrres';

    l_tabname    varchar2(30);  /* имя таблицы ресурса */
    l_usercol    varchar2(30);  /* имя колонки пользователя */

    l_stmt       varchar2(4000);/* текст запроса */

    l_cno        t_chandle;            /*              идентификатор курсора */
    l_rowcnt     number;

    l_respkrow   t_anyrow := t_anyrow();
    l_resrow     t_anyrow := t_anyrow();


    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s ...', p, to_char(p_userid), to_char(p_resid));

        -- получаем имя таблицы и имя колонки ид. пользователя
        begin
            select res_tabname, res_usercol
              into l_tabname, l_usercol
              from sec_resources
             where res_id = p_resid;
        end;
        bars_audit.trace('%s: res table %s, user col %s', p, l_tabname, l_usercol);

        -- конвертируем параметры
        icnv_cols(p_resid, p_pkcolnames, p_pkcolvals, l_respkrow);
        icnv_cols(p_resid, p_colnames,   p_colvals,   l_resrow  );

        -- проверка грантора только при подтверждении прав
        if need_check_grantor(p_colnames) then
           check_grantor(
                     p_tablename  => l_tabname,
                     p_usercol    => l_usercol,
                     p_respkrow   => l_respkrow,
                     p_resid      => p_userid );
        end if;

        -- Формируем запрос для обновления
        l_stmt := 'update ' || l_tabname || ' set ' ||
                  isvc_coltab2pair(l_resrow, ', ')  ||
                  ' where ' || l_usercol || ' = :userid and ' || isvc_coltab2pair(l_respkrow, ' and ');
        bars_audit.trace('%s: change stmt is %s', p, l_stmt);

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        isvc_cbind(l_cno, l_resrow);
        dbms_sql.bind_variable(l_cno, 'userid',  p_userid);
        isvc_cbind(l_cno, l_respkrow);

        -- Выполняем
        bars_audit.trace('%s: changing resource...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row updated.', p, to_char(l_rowcnt));

        bars_audit.trace('%s: succ end');

    end alter_user_resource;

    -----------------------------------------------------------------
    -- CHANGE_SCHEME_PRIVS()
    --
    --     Процедура выдачи/отзыва привилегий для
    --     общей схемы пользователей
    --
    --     Параметры:
    --
    --         p_schemeid    Ид. схемы
    --
    procedure change_scheme_privs(
                  p_schemeid    in  staff_templates.scheme_id%type )
    is
    l_schemerole staff_templ_schemes.scheme_role%type;
    begin

        select scheme_role into l_schemerole
          from staff_templ_schemes
         where scheme_id = p_schemeid;

        for c in (with r1 as (select distinct(rolename) rolename
                                from (select upper(l.rolename) rolename
                                        from applist_staff s, operapp a, operlist l
                                       where s.id in (select s.id
                                                        from staff_templates st, staff$base s
                                                       where st.scheme_id = p_schemeid
                                                         and st.templ_id  = s.templ_id )
                                         and s.approve  = 1
                                         and s.codeapp  = a.codeapp
                                         and a.approve  = 1
                                         and a.codeoper = l.codeoper
                                         and l.rolename is not null
                                         and l.frontend = 1         -- Web only
                              union all
                              select upper(r.role2edit) rolename
                                from applist_staff s, refapp l, references r
                               where s.id in (select s.id
                                                from staff_templates st, staff$base s
                                               where st.scheme_id = p_schemeid
                                                 and st.templ_id  = s.templ_id)
                                 and s.approve  = 1
                                 and s.codeapp  = l.codeapp
                                 and l.approve  = 1
                                 and l.tabid    = r.tabid
                                 and r.role2edit is not null)),
                       r2 as (select r.rolename
                                from (select distinct granted_role rolename
                                        from role_role_privs
                                      start with role in (select rolename from r1)
                                      connect by prior granted_role = role
                                      union
                                      select rolename from r1) r,
                                     roles$base rb
                               where r.rolename = rb.role_name)
                  select 'P' type, sp1.privilege, null table_name
                    from (select distinct sp.privilege
                            from role_sys_privs sp
                           where sp.role in (select rolename from r2)) sp1
                  union all
                  select 'T' type, sp2.privilege, sp2.table_name
                    from (select distinct privilege, table_name
                            from role_tab_privs
                           where role in (select rolename from r2)
                             and owner = 'BARS') sp2
                  union all
                  select 'T' type, 'EXECUTE', 'BARS_LOGIN' from dual
                  union all
                  select 'P' type, 'CREATE SESSION', null from dual
                  minus
                  select 'P' type, privilege, null
                    from role_sys_privs
                   where role = l_schemerole
                  minus
                  select 'T', privilege, table_name
                    from role_tab_privs
                   where role = l_schemerole)
        loop
            if (c.type = 'P') then
                execute immediate 'grant ' || c.privilege || ' to ' || l_schemerole;
            else
                execute immediate 'grant ' || c.privilege || ' on "' || c.table_name || '" to ' || l_schemerole;
            end if;
        end loop;

    end change_scheme_privs;

    -----------------------------------------------------------------
    -- CHANGE_USER_PRIVS()
    --
    --     Процедура выдачи/отзыва привилегий пользователя в
    --     в зависимости от выданных ему ресурсов
    --
    --     Параметры:
    --
    --         p_userid     Ид. пользователя
    --
    procedure change_user_privs(
                  p_userid     in  staff$base.id%type )
    is

    p            constant varchar2(100)  := 'useradm.chgusrprv';

    l_usrlogname staff$base.logname%type;
    l_usrscheme  staff_templ_schemes.scheme_id%type;
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_userid));

        select s.logname, st.scheme_id
          into l_usrlogname, l_usrscheme
          from staff$base s, staff_templates st
         where s.id         = p_userid
           and s.templ_id   = st.templ_id;
        bars_audit.trace('%s: logname is %s, scheme %s', p, l_usrlogname, to_char(l_usrscheme));

        -- выдаем ресурсы
        for c in (select distinct(rolename) rolename
                    from (select upper(l.rolename) rolename
                            from applist_staff s, operapp a, operlist l
                           where s.id       = p_userid
                             and s.approve  = 1
                             and s.codeapp  = a.codeapp
                             and a.approve  = 1
                             and a.codeoper = l.codeoper
                             and l.rolename is not null
                          union all
                          select upper(r.role2edit) rolename
                            from applist_staff s, refapp l, references r
                           where s.id       = p_userid
                             and s.approve  = 1
                             and s.codeapp  = l.codeapp
                             and l.approve  = 1
                             and l.tabid    = r.tabid
                             and r.role2edit is not null)
                  minus
                  select granted_role rolename
                    from dba_role_privs
                   where grantee = l_usrlogname)
        loop
            bars_audit.trace('%s: granting role %s...', p, c.rolename);
            execute immediate 'grant ' || c.rolename || ' to ' || l_usrlogname;
        end loop;
        bars_audit.trace('%s: all application roles granted', p);

        -- У пользователей со схемами права не забираем
        if (l_usrlogname not in ('BARS', 'HIST')) then

            -- забираем лишние роли
            for c in (select p.granted_role rolename
                        from dba_role_privs p,
                             (select distinct rolename
                                from (select upper(rolename) rolename
                                        from operlist
                                       where rolename is not null
                                      union all
                                      select upper(role2edit) rolename
                                        from references
                                       where role2edit is not null)) r
                       where p.grantee      = l_usrlogname
                         and p.granted_role = r.rolename
                         and p.granted_role != 'START1'
                      minus
                      select distinct(rolename) rolename
                        from (select upper(l.rolename) rolename
                                from applist_staff s, operapp a, operlist l
                               where s.id       = p_userid
                                 and s.approve  = 1
                                 and s.codeapp  = a.codeapp
                                 and a.approve  = 1
                                 and a.codeoper = l.codeoper
                                 and l.rolename is not null
                              union all
                              select upper(r.role2edit) rolename
                                from applist_staff s, refapp l, references r
                               where s.id       = p_userid
                                 and s.approve  = 1
                                 and s.codeapp  = l.codeapp
                                 and l.approve  = 1
                                 and l.tabid    = r.tabid
                                 and r.role2edit is not null))
            loop
                bars_audit.trace('%s: revoking role %s...', p, c.rolename);
                execute immediate 'revoke ' || c.rolename || ' from ' || l_usrlogname;
            end loop;
            bars_audit.trace('%s: all application roles revoked.', p);
        end if;

        -- Обрабатываем общие схемы
        change_scheme_privs(l_usrscheme);
        bars_audit.trace('%s: shared scheme updated', p);

        bars_audit.trace('%s: succ end');

    exception when no_data_found then
        bars_audit.trace('%s: user ' || p_userid || ' not found or dropped.', p);
    end change_user_privs;


    -----------------------------------------------------------------
    -- set_app_context
    --
    procedure set_app_context (p_codeapp applist.codeapp%type) is
    begin
        sys.dbms_session.set_context('bars_useradm', 'codeapp', p_codeapp);
    end;


    -----------------------------------------------------------------
    -- Procedure   : create_app
    -- Description : Процедура создания АРМа
    -- Params:
    --   p_appid    - код АРМа
    --   p_appname  - наименование АРМа
    --   p_frontend - код фронтального интерфейса
    --
    procedure create_app (
                  p_appid      applist.codeapp%type,
                  p_appname    applist.name%type,
                  p_frontend   applist.frontend%type )
    is

    p             constant varchar2(100)  := 'usradm.crapp';

    begin

        bars_audit.trace('%s: entry point par[0]=>%s, par[1]=>%s par[2]=>%s', p, p_appid, p_appname, to_char(p_frontend));

        insert into applist (codeapp, name, frontend)
        values (p_appid, p_appname, nvl(p_frontend,0));

        bars_audit.trace('%s: succ end', p);

    end create_app;


    -----------------------------------------------------------------
    -- Procedure   : alter_app
    -- Description : Процедура обновления АРМа
    -- Params:
    --   p_appid    - код АРМа
    --   p_appname  - наименование АРМа
    --   p_frontend - код фронтального интерфейса
    --
    procedure alter_app (
                  p_appid      applist.codeapp%type,
                  p_appname    applist.name%type,
                  p_frontend   applist.frontend%type )
    is

    p             constant varchar2(100)  := 'usradm.altapp';

    begin

         bars_audit.trace('%s: entry point par[0]=>%s, par[1]=>%s par[2]=>%s', p, p_appid, p_appname, to_char(p_frontend));

         update applist
            set name     = p_appname,
                frontend = p_frontend
          where codeapp  = p_appid;

         bars_audit.trace('%s: succ end', p);

    end alter_app;


    -----------------------------------------------------------------
    -- Procedure   : drop_app
    -- Description : Процедура удаления АРМа
    -- Params:
    --   p_appid - код АРМа
    --
    procedure drop_app ( p_appid  applist.codeapp%type )
    is

    p             constant varchar2(100)  := 'usradm.drpapp';

    begin

        bars_audit.trace('%s: entry point par[0]=>%s', p, p_appid);

        delete from applist where codeapp = p_appid ;

        bars_audit.trace('%s: succ end', p);

    end drop_app;


    -----------------------------------------------------------------
    -- Procedure   : alter_app_resource
    -- Description : Процедура изменения параметров ресурса у АРМа
    -- Params:
    --   p_appid      - код АРМа
    --   p_resid      - код ресурса
    --   p_pkcolnames - список имен столбцов перв. ключа
    --   p_pkcolvals  - список значений столбцов перв. ключа
    --   p_colnames   - список имен изменяемых реквизитов
    --   p_colvals    - список значений изменяемых реквизитов
    --
    procedure alter_app_resource(
                  p_appid      in  applist.codeapp%type,
                  p_resid      in  sec_resources.res_id%type,
                  p_pkcolnames in  t_varchar2list,
                  p_pkcolvals  in  t_varchar2list,
                  p_colnames   in  t_varchar2list,
                  p_colvals    in  t_varchar2list )
    is

    p             constant varchar2(100)  := 'usradm.altappres';

    l_tabname     varchar2(30);  /* имя таблицы ресурса */
    l_usercol     varchar2(30);  /* имя колонки пользователя */

    l_stmt        varchar2(4000);/* текст запроса */

    l_cno         t_chandle;     /* идентификатор курсора */
    l_rowcnt      number;

    l_respkrow    t_anyrow := t_anyrow();
    l_resrow      t_anyrow := t_anyrow();

    begin

        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s ...', p, p_appid, to_char(p_resid));

        -- получаем имя таблицы и имя колонки ид. АРМа
        begin
            select res_tabname, res_usercol
              into l_tabname, l_usercol
              from sec_resources
             where res_id = p_resid;
        end;
        bars_audit.trace('%s: res table %s, user col %s', p, l_tabname, l_usercol);

        -- конвертируем параметры
        icnv_cols(p_resid, p_pkcolnames, p_pkcolvals, l_respkrow);
        icnv_cols(p_resid, p_colnames,   p_colvals,   l_resrow  );

        -- проверка грантора только при подтверждении прав
        if need_check_grantor(p_colnames) then
           check_grantor(
                     p_tablename  => l_tabname,
                     p_usercol    => l_usercol,
                     p_respkrow   => l_respkrow,
                     p_resid      =>  p_appid );
        end if;

    -- Формируем запрос
        l_stmt := 'update ' || l_tabname || ' set ' ||
                  isvc_coltab2pair(l_resrow, ', ')  ||
                  ' where ' || l_usercol || ' = :appid and ' || isvc_coltab2pair(l_respkrow, ' and ');
        bars_audit.trace('%s: change stmt is %s', p, l_stmt);

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        isvc_cbind(l_cno, l_resrow);
        dbms_sql.bind_variable(l_cno, 'appid',  p_appid);
        isvc_cbind(l_cno, l_respkrow);

        -- Выполняем
        bars_audit.trace('%s: changing resource...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row updated.', p, to_char(l_rowcnt));

        bars_audit.trace('%s: succ end');

    end alter_app_resource;


    -----------------------------------------------------------------
    -- Procedure   : grant_app_resource
    -- Description : Процедура выдачи ресурса АРМу
    -- Params:
    --   p_appid    - код АРМа
    --   p_resid    - код ресурса
    --   p_colnames - список имен реквизитов
    --   p_colvals  - список значений реквизитов
    --
    procedure grant_app_resource (
                  p_appid    in  applist.codeapp%type,
                  p_resid    in  sec_resources.res_id%type,
                  p_colnames in  t_varchar2list,
                  p_colvals  in  t_varchar2list )
    is

    p             constant varchar2(100)  := 'usradm.grntappres';

    l_resrow      t_anyrow := t_anyrow();

    l_resapprove  number;        /* признак необходимости подтверждения */

    l_tabname     varchar2(30);  /* имя таблицы ресурса */
    l_usercol     varchar2(30);  /* имя колонки пользователя */

    l_stmt        varchar2(4000);/* текст запроса */

    l_cno         t_chandle;     /* идентификатор курсора */
    l_rowcnt      number;

    l_resaprstate sec_resources.res_approve%type;   /* признак подтверждаемости ресурса */
    l_resaproc    sec_resources.res_afterproc%type; /* имя пост-процедуры */

    begin

        bars_audit.trace('%s: entry point par[0]=>%s, par[1]=>%s par[2]=>...par[3]=>...', p, p_appid, to_char(p_resid));

        -- получаем имя таблицы и имя колонки ид. пользователя, признак подтверждаемости
        begin
            select res_tabname, res_usercol, res_approve, res_afterproc
              into l_tabname, l_usercol, l_resaprstate, l_resaproc
              from sec_resources
             where res_id = p_resid;
        end;
        bars_audit.trace('%s: res table %s, user col %s, apr state %s', p, l_tabname, l_usercol, l_resaprstate);

        -- конвертируем параметры во внутренюю структуру
        icnv_cols(p_resid, p_colnames, p_colvals, l_resrow);
        bars_audit.trace('%s: parameters converted to int storage', p);

        -- получаем признак автоподтверждения
        if (l_resaprstate = RESOURCE_APPROVED) then

           if (nvl(to_number(get_param(PARAM_LOSEC)), 0) = PARAMV_LOSEC) then
              l_resapprove := USER_APPROVED;
           else
              l_resapprove := USER_NOTAPPROVED;
           end if;
           bars_audit.trace('%s: auto approve is %s', p, to_char(l_resapprove));

        end if;

        -- Формируем запрос на вставку
        l_stmt := 'insert into ' || l_tabname || '(' || l_usercol || ', ';

        if (l_resaprstate = RESOURCE_APPROVED) then
           l_stmt := l_stmt || 'approve, grantor, ';
        end if;

        l_stmt := l_stmt || isvc_coltab2list(l_resrow) || ')' || ' values (:appid, ';

        if (l_resaprstate = RESOURCE_APPROVED) then
           l_stmt := l_stmt || ':approve, :grantor, ';
        end if;

        l_stmt := l_stmt || isvc_coltab2list(l_resrow, ':') || ')';
        bars_audit.trace('%s: res grant stmt is %s', p, l_stmt);

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        dbms_sql.bind_variable(l_cno, 'appid', p_appid);

        if (l_resaprstate = RESOURCE_APPROVED) then
           dbms_sql.bind_variable(l_cno, 'approve', l_resapprove);
           dbms_sql.bind_variable(l_cno, 'grantor', user_id);
        end if;

        isvc_cbind(l_cno, l_resrow);

        -- Выполняем
        bars_audit.trace('%s: inserting resource...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row inserted.', p, to_char(l_rowcnt));

        -- Выполняем пост-процедуру
        if (l_resaproc is not null) then
           execute immediate 'begin ' || l_resaproc || '(:appid); end;'
           using p_appid;
        end if;

        if (l_resaprstate = RESOURCE_APPROVED and l_resapprove = USER_NOTAPPROVED) then
           g_lastmsg := bars_msg.get_msg(MODCODE, 'RESOURCE_NEED_APPROVE');
        else
           g_lastmsg := null;
        end if;

        bars_audit.security('Выдан ресурс АРМу');
        bars_audit.trace('%s: succ end', p);

    end grant_app_resource;


    -----------------------------------------------------------------
    -- Procedure   : revoke_app_resource
    -- Description : Процедура отзыва ресурса у АРМа
    -- Params:
    --   p_appid    - код АРМа
    --   p_resid    - код ресурса
    --   p_colnames - список имен реквизитов
    --   p_colvals  - список значений реквизитов
    --
    procedure revoke_app_resource (
                  p_appid    in  applist.codeapp%type,
                  p_resid    in  sec_resources.res_id%type,
                  p_colnames in  t_varchar2list,
                  p_colvals  in  t_varchar2list )
    is
    p             constant varchar2(100)  := 'usradm.revappres';

    l_resrow      t_anyrow := t_anyrow();

    l_resapprove  number;        /* признак необходимости подтверждения */

    l_tabname     varchar2(30);  /* имя таблицы ресурса */
    l_usercol     varchar2(30);  /* имя колонки пользователя */

    l_stmt        varchar2(4000);/* текст запроса */

    l_cno         t_chandle;     /* идентификатор курсора */
    l_rowcnt      number;

    l_resstate    number;

    l_resaprstate sec_resources.res_approve%type;   /* признак подтверждаемости ресурса */
    l_resaproc    sec_resources.res_afterproc%type; /* имя пост-процедуры */

    begin

        bars_audit.trace('%s: entry point par[0]=>%s, par[1]=>%s par[2]=>...par[3]=>...', p, p_appid, to_char(p_resid));

        -- получаем имя таблицы и имя колонки ид. пользователя, признак подтверждаемости
        begin
            select res_tabname, res_usercol, res_approve, res_afterproc
              into l_tabname, l_usercol, l_resaprstate, l_resaproc
              from sec_resources
             where res_id = p_resid;
        end;
        bars_audit.trace('%s: res table %s, user col %s, apr state %s', p, l_tabname, l_usercol, l_resaprstate);

        -- конвертируем параметры во внутренюю структуру
        icnv_cols(p_resid, p_colnames, p_colvals, l_resrow);
        bars_audit.trace('%s: parameters converted to int storage', p);

        -- получаем признак автоподтверждения
        if (l_resaprstate = RESOURCE_APPROVED) then

           if (nvl(to_number(get_param(PARAM_LOSEC)), 0) = PARAMV_LOSEC) then
              l_resapprove := USER_NOTAPPROVED;
           else
              l_resapprove := USER_APPROVED;
           end if;
           bars_audit.trace('%s: auto approve is %s', p, to_char(l_resapprove));

        end if;

        -- получаем признак автоподтверждения
        if (l_resaprstate = RESOURCE_APPROVED) then

           -- получаем значение поля approve
           l_stmt := 'select approve from ' || l_tabname || ' where ' || l_usercol || ' = :appid and ' ||
                      isvc_coltab2pair(l_resrow, ' and ');
           bars_audit.trace('%s: get approve stmt is %s', p, l_stmt);

           l_cno := isvc_cprep(l_stmt);

           -- Привязываем переменные
           dbms_sql.bind_variable(l_cno, 'appid',  p_appid);
           isvc_cbind(l_cno, l_resrow);

           -- определяем возвращаемый столбец
           dbms_sql.define_column(l_cno, 1, l_resstate);

           -- Выполняем
           bars_audit.trace('%s: executing statement...', p);
           l_rowcnt := dbms_sql.execute_and_fetch(l_cno);

           -- Получаем значение
           dbms_sql.column_value(l_cno, 1, l_resstate);
           bars_audit.trace('%s: approve for row is %s', p, to_char(l_resstate));
           dbms_sql.close_cursor(l_cno);

        end if;

        if (l_resaprstate = RESOURCE_APPROVED and l_resapprove = USER_APPROVED and l_resstate = USER_APPROVED) then

           -- ставим признак отозванного
           l_stmt := 'update ' || l_tabname || ' set revoked = 1, grantor = user_id where '  || l_usercol || ' = :appid and ' ||
                      isvc_coltab2pair(l_resrow, ' and ');
              bars_audit.trace('%s: revoke stmt is %s', p, l_stmt);

           -- формируем сообщение
           g_lastmsg := bars_msg.get_msg(MODCODE, 'RESOURCE_NEED_APPROVE');

        else

           -- сразу удаляем
           l_stmt := 'delete from ' || l_tabname || ' where '  || l_usercol || ' = :appid and ' ||
                      isvc_coltab2pair(l_resrow, ' and ');
           bars_audit.trace('%s: revoke stmt is %s', p, l_stmt);

           -- сообщение не требуется
           g_lastmsg := null;

        end if;

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        dbms_sql.bind_variable(l_cno, 'appid',  p_appid);
        isvc_cbind(l_cno, l_resrow);

        -- Выполняем
        bars_audit.trace('%s: revoking resource...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row deleted.', p, to_char(l_rowcnt));

        -- Выполняем пост-процедуру
        if (l_resaproc is not null) then
           execute immediate 'begin ' || l_resaproc || '(:appid); end;'
           using p_appid;
        end if;

        bars_audit.security('Ресурс АРМа отозван');
        bars_audit.trace('%s: succ end', p);

    end revoke_app_resource;


    -----------------------------------------------------------------
    -- Procedure   : change_app_privs
    -- Description : Процедура выдачи/отзыва привилегий пользователям
    --               в зависимости от выданных АРМу функций, справочников
    -- Params:
    --   p_appid - код АРМа
    --
    procedure change_app_privs ( p_appid in applist.codeapp%type )
    is

    p             constant varchar2(100)  := 'usradm.chgappprv';

    begin

        bars_audit.trace('%s: entry point par[0]=>%s', p, p_appid);

        -- каким пользователям выдан АРМ
        for k in ( select s.id, s.logname
                     from staff$base s, applist_staff a
                    where s.id      = a.id
                      and a.codeapp = p_appid
                      and a.approve = 1 )
        loop
            bars_audit.trace('%s: logname is %s', p, k.logname);

            -- выдаем ресурсы
            for c in ( select distinct(rolename) rolename
                         from ( select upper(l.rolename) rolename
                                  from applist_staff s, operapp a, operlist l
                                 where s.id       = k.id
                                   and s.codeapp  = p_appid
                                   and s.approve  = 1
                                   and s.codeapp  = a.codeapp
                                   and a.approve  = 1
                                   and a.codeoper = l.codeoper
                                   and l.rolename is not null
                                union all
                                select upper(r.role2edit) rolename
                                  from applist_staff s, refapp a, references r
                                 where s.id       = k.id
                                   and s.codeapp  = p_appid
                                   and s.approve  = 1
                                   and s.codeapp  = a.codeapp
                                   and a.approve  = 1
                                   and a.tabid    = r.tabid
                                   and r.role2edit is not null)
                       minus
                       select granted_role rolename
                         from dba_role_privs
                        where grantee = k.logname )
            loop

                bars_audit.trace('%s: granting role %s...', p, c.rolename);
                execute immediate 'grant ' || c.rolename || ' to ' || k.logname;

            end loop;

            bars_audit.trace('%s: all application roles granted', p);

            -- забираем лишние роли
            for c in ( select p.granted_role rolename
                         from dba_role_privs p,
                              ( select distinct rolename
                                  from ( select upper(rolename) rolename
                                           from operlist
                                          where rolename is not null
                                         union all
                                         select upper(role2edit) rolename
                                           from references
                                          where role2edit is not null ) ) r
                        where p.grantee       = k.logname
                          and p.granted_role  = r.rolename
                          and p.granted_role != 'START1'
                       minus
                       select distinct(rolename) rolename
                         from ( select upper(l.rolename) rolename
                                  from applist_staff s, operapp a, operlist l
                                 where s.id       = k.id
                                   and s.approve  = 1
                                   and s.codeapp  = a.codeapp
                                   and a.approve  = 1
                                   and a.codeoper = l.codeoper
                                   and l.rolename is not null
                                union all
                                select upper(r.role2edit) rolename
                                  from applist_staff s, refapp a, references r
                                 where s.id       = k.id
                                   and s.approve  = 1
                                   and s.codeapp  = a.codeapp
                                   and a.approve  = 1
                                   and a.tabid    = r.tabid
                                   and r.role2edit is not null ) )
            loop

                if k.logname<>'BARS' then

                    bars_audit.trace('%s: revoking role %s...', p, c.rolename);
                    execute immediate 'revoke ' || c.rolename || ' from ' || k.logname;

                end if;

            end loop;

            bars_audit.trace('%s: all application roles revoked.', p);

        end loop;

        bars_audit.trace('%s: succ end', p);

    end change_app_privs;


    -----------------------------------------------------------------
    -- Procedure   : drop_user_resource
    -- Description : Процедура изъятия ресурса
    -- Params:
    --   p_userid     - код Пользователя
    --   p_resid      - код ресурса
    --   p_pkcolnames - список имен столбцов перв. ключа
    --   p_pkcolvals  - список значений столбцов перв. ключа
    --
    procedure drop_user_resource (
                  p_userid     in  staff$base.id%type,
                  p_resid      in  sec_resources.res_id%type,
                  p_pkcolnames in  t_varchar2list,
                  p_pkcolvals  in  t_varchar2list )
    is

    p             constant varchar2(100)  := 'useradm.dropusrres';

    l_tabname     varchar2(30);  /* имя таблицы ресурса */
    l_usercol     varchar2(30);  /* имя колонки пользователя */

    l_stmt        varchar2(4000);/* текст запроса */

    l_cno         t_chandle;     /* идентификатор курсора */
    l_rowcnt      number;

    l_respkrow    t_anyrow := t_anyrow();
    l_resrow      t_anyrow := t_anyrow();

    begin

        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s ...', p, to_char(p_userid), to_char(p_resid));

        -- получаем имя таблицы и имя колонки ид. пользователя
        begin
            select res_tabname, res_usercol
              into l_tabname, l_usercol
              from sec_resources
             where res_id = p_resid;
        end;
        bars_audit.trace('%s: res table %s, user col %s', p, l_tabname, l_usercol);

        -- конвертируем параметры
        icnv_cols(p_resid, p_pkcolnames, p_pkcolvals, l_respkrow);

    check_grantor(
                  p_tablename  => l_tabname,
                  p_usercol    => l_usercol,
                  p_respkrow   => l_respkrow,
                  p_resid      => p_userid );

    -- Формируем запрос
        l_stmt := 'delete from ' || l_tabname ||
                  ' where ' || l_usercol || ' = :userid and ' || isvc_coltab2pair(l_respkrow, ' and ');
        bars_audit.trace('%s: delete stmt is %s', p, l_stmt);

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        isvc_cbind(l_cno, l_resrow);
        dbms_sql.bind_variable(l_cno, 'userid',  p_userid);
        isvc_cbind(l_cno, l_respkrow);

        -- Выполняем
        bars_audit.trace('%s: deleting resource...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row deleted.', p, to_char(l_rowcnt));

        bars_audit.trace('%s: succ end', p);

    end drop_user_resource;


    -----------------------------------------------------------------
    -- Procedure   : drop_app_resource
    -- Description : Процедура изъятия ресурса у АРМа
    -- Params:
    --   p_appid      - код АРМа
    --   p_resid      - код ресурса
    --   p_pkcolnames - список имен столбцов перв. ключа
    --   p_pkcolvals  - список значений столбцов перв. ключа
    --
    procedure drop_app_resource (
                  p_appid      in  applist.codeapp%type,
                  p_resid      in  sec_resources.res_id%type,
                  p_pkcolnames in  t_varchar2list,
                  p_pkcolvals  in  t_varchar2list )
    is

    p             constant varchar2(100)  := 'useradm.dropappres';

    l_tabname     varchar2(30);  /* имя таблицы ресурса */
    l_usercol     varchar2(30);  /* имя колонки пользователя */

    l_stmt        varchar2(4000);/* текст запроса */

    l_cno         t_chandle;     /* идентификатор курсора */
    l_rowcnt      number;

    l_respkrow    t_anyrow := t_anyrow();
    l_resrow      t_anyrow := t_anyrow();

    begin

        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s ...', p, p_appid, to_char(p_resid));

        -- получаем имя таблицы и имя колонки ид. АРМа
        begin
            select res_tabname, res_usercol
              into l_tabname, l_usercol
              from sec_resources
             where res_id = p_resid;
        end;
        bars_audit.trace('%s: res table %s, user col %s', p, l_tabname, l_usercol);

        -- конвертируем параметры
        icnv_cols(p_resid, p_pkcolnames, p_pkcolvals, l_respkrow);

        check_grantor(
                  p_tablename  => l_tabname,
                  p_usercol    => l_usercol,
                  p_respkrow   => l_respkrow,
                  p_resid      => p_appid );

    -- Формируем запрос
        l_stmt := 'delete from ' || l_tabname ||
                  ' where ' || l_usercol || ' = :appid and ' || isvc_coltab2pair(l_respkrow, ' and ');
        bars_audit.trace('%s: delete stmt is %s', p, l_stmt);

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        isvc_cbind(l_cno, l_resrow);
        dbms_sql.bind_variable(l_cno, 'appid',  p_appid);
        isvc_cbind(l_cno, l_respkrow);

        -- Выполняем
        bars_audit.trace('%s: deleting resource...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row deleted.', p, to_char(l_rowcnt));

        bars_audit.trace('%s: succ end', p);

    end drop_app_resource;



    -----------------------------------------------------------------
    -- CREATE_USER_GTW()
    --
    --     Создание учетной записи пользователя после подтверждения
    --
    --
    --
    procedure create_user_gtw(
                  p_userid      staff$base.id%type )
    is
    p             constant varchar2(100)  := 'useradm.crusrgtw';
    --
    l_usrlogname  staff$base.logname%type;          /*    Имя учетной записи пользователя */
    l_usrstmtcr   staff_storage.storage_stmt%type;  /* выражение на создание пользователя */
    l_usrdefrole  staff_storage.roles%type;         /*                 Умолчательная роль */
    l_usrdefts    staff_storage.grants%type;        /*      Табличное пространство польз. */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_userid));

        -- Читаем реквизиты пользователя
        select logname
          into l_usrlogname
          from staff$base
         where id = p_userid;

        select storage_stmt, roles, grants
          into l_usrstmtcr, l_usrdefrole, l_usrdefts
          from staff_storage
         where id = p_userid;
        bars_audit.trace('%s: user create statement selected', p);

        -- создаем пользователя
        execute immediate l_usrstmtcr;
        bars_audit.trace('%s: database account created.', p);

        if (l_usrdefts is not null) then
            -- даем квоту на табл. пространство
            execute immediate 'alter user ' || l_usrlogname || ' quota unlimited on ' || l_usrdefts;
            bars_audit.trace('%s: qouta granted.', p);
        end if;

        -- даем право на соединение
        execute immediate 'grant create session to ' || l_usrlogname;
        bars_audit.trace('%s: create session granted.', p);

        if (l_usrdefrole is not null) then
            -- выдаем умолчательную роль
            execute immediate 'grant ' || l_usrdefrole || ' to ' || l_usrlogname;
            bars_audit.trace('%s: default role(s) %s granted.', p, l_usrdefrole);

            -- устанавливаем умолчат. роль
            execute immediate 'alter user ' || l_usrlogname || ' default role ' || l_usrdefrole;
            bars_audit.trace('%s: default role %s is set for user.', p, l_usrdefrole);
        end if;

        -- Устанавливаем признак подтверждения
        update staff$base
           set approve = USER_APPROVED
         where id = p_userid;
        bars_audit.trace('%s: user approve flag is set', p);

        delete from staff_storage
         where id = p_userid;
        bars_audit.trace('%s: succ end', p);

    end create_user_gtw;


    -----------------------------------------------------------------
    -- GET_USERPWD_CHANGE()
    --
    --     Получение признак необходимости смены пароля пользователем
    --
    --     Параметры:
    --
    --       p_userid    Ид. пользователя
    --
    function get_userpwd_change(
                  p_userid      staff$base.id%type ) return char
    is
    p             constant varchar2(100)  := 'useradm.getusrpwdchg';
    --
    l_chgpwd  staff$base.chgpwd%type;  /*  Признак необх. смены пароля */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_userid));

        select nvl(chgpwd, 'N') into l_chgpwd
          from staff$base
         where id = p_userid;
        bars_audit.trace('%s: user chgpwd is %s', p, l_chgpwd);
        bars_audit.trace('%s: succ end, return %s', p, l_chgpwd);
        return l_chgpwd;
    exception
        when NO_DATA_FOUND then
            bars_audit.trace('%s: error detected - user with id %s not found', p, to_char(p_userid));
            bars_error.raise_nerror(MODCODE, 'USER_NOT_FOUND', to_char(p_userid));
    end get_userpwd_change;


    -----------------------------------------------------------------
    -- CHANGE_USER_PASSWORD()
    --
    --     Смена пароля пользователя
    --
    --     Параметры:
    --
    --       p_userid    Ид. пользователя
    --
    --       p_password  Пароль пользователя
    --
    procedure change_user_password(
                  p_userid    in staff$base.id%type,
                  p_password  in varchar2            )
    is
    p             constant varchar2(100)  := 'useradm.chgusrpwd';
    --
    l_usrlogname  staff$base.logname%type;  /* Имя учетной записи пользователя */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=><wrapped>', p, to_char(p_userid));

        begin
            select logname into l_usrlogname
              from staff$base
             where id = p_userid;
            bars_audit.trace('%s: user logname is %s', p, l_usrlogname);
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('%s: error detected - user with id %s not found', p, to_char(p_userid));
                bars_error.raise_nerror(MODCODE, 'USER_NOT_FOUND', to_char(p_userid));
        end;

        -- Меняем пароль пользователя
        execute immediate 'alter user ' || l_usrlogname || ' identified by ' || p_password;
        bars_audit.trace('%s: user password changed', p);

        -- Сбрасываем флаг смены пароля
        update staff$base
           set chgpwd = null
         where id = p_userid
           and chgpwd is not null;
        bars_audit.trace('%s: user flag "need change password" is cleared', p);
        bars_audit.trace('%s: succ end', p);

    end change_user_password;


    -----------------------------------------------------------------
    -- SET_STAFFTIP_CONTEXT()
    --
    --     Процедура установки контекста для просмотра ресурсов
    --     указанного типового пользователя
    --
    --     Параметры:
    --
    --      p_tipid    Ид. типового пользователя
    --
    procedure set_stafftip_context(
        p_tipid  in  staff$base.tip%type)
    is
    begin
        sys.dbms_session.set_context('bars_useradm', 'stafftip_id', p_tipid);
    end set_stafftip_context;


    -----------------------------------------------------------------
    -- GRANT_STAFFTIP_RESOURCE()
    --
    --     Процедура выдачи ресурса типовым пользователям
    --
    --     Параметры:
    --
    --         p_tipid     Ид. типового пользователя
    --
    --         p_resid     Ид. ресурса
    --
    --         p_colnames  Список имен реквизитов
    --
    --         p_colvals   Список значений реквизитов
    --
    --
    procedure grant_stafftip_resource(
                  p_tipid    in  staff$base.tip%type,
                  p_resid    in  sec_resources.res_id%type,
                  p_colnames in  t_varchar2list,
                  p_colvals  in  t_varchar2list             )
    is

    p            constant varchar2(100)  := 'useradm.grntusrtipres';

    l_resrow     t_anyrow := t_anyrow();

    l_tabname    varchar2(30);  /* имя таблицы ресурса */
    l_usercol    varchar2(30);  /* имя колонки пользователя */

    l_stmt       varchar2(4000);/* текст запроса */

    l_cno        t_chandle;     /* идентификатор курсора */
    l_rowcnt     number;

    begin

        bars_audit.trace('useradm.grntures: entry point par[0]=>%s, par[1]=>%s par[2]=>...par[3]=>...', to_char(p_tipid), to_char(p_resid));

        -- получаем имя таблицы и имя колонки ид. пользователя
        begin
            select res_tipstabname, res_usercol
              into l_tabname, l_usercol
              from sec_resources
             where res_id = p_resid;
        end;
        bars_audit.trace('%s: res table %s, user col %s, apr state %s', p, l_tabname, l_usercol);

        -- конвертируем параметры во внутренюю структуру
        icnv_cols(p_resid, p_colnames, p_colvals, l_resrow);
        bars_audit.trace('%s: parameters converted to int storage', p);

        -- Формируем запрос на вставку
        l_stmt := 'insert into ' || l_tabname || '(' || l_usercol || ', ';

        l_stmt := l_stmt || isvc_coltab2list(l_resrow) || ')' || ' values (:tipid, ';

        l_stmt := l_stmt || isvc_coltab2list(l_resrow, ':') || ')';
        bars_audit.trace('%s: res grant stmt is %s', p, l_stmt);

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        dbms_sql.bind_variable(l_cno, 'tipid',  p_tipid);

        isvc_cbind(l_cno, l_resrow);

        -- Выполняем
        bars_audit.trace('%s: inserting resource...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row inserted.', p, to_char(l_rowcnt));

        -- Выдаем ресурсы пользователям
        for s in ( select id from staff$base where tip = p_tipid )
        loop

            grant_user_resource(
                  s.id,
                  p_resid,
                  p_colnames,
                  p_colvals );

        end loop;

        bars_audit.trace('%s: succ end', p);

    end grant_stafftip_resource;


    -----------------------------------------------------------------
    -- REVOKE_STAFFTIP_RESOURCE()
    --
    --     Процедура отзыва ресурса у типовых пользователей
    --
    --     Параметры:
    --
    --         p_tipid     Ид. типового пользователя
    --
    --         p_resid     Ид. ресурса
    --
    --         p_colnames  Список имен реквизитов
    --
    --         p_colvals   Список значений реквизитов
    --
    --
    procedure revoke_stafftip_resource(
                  p_tipid    in  staff$base.tip%type,
                  p_resid    in  sec_resources.res_id%type,
                  p_colnames in  t_varchar2list,
                  p_colvals  in  t_varchar2list             )
    is
    p            constant varchar2(100)  := 'useradm.revusrtipres';

    l_resrow     t_anyrow := t_anyrow();

    l_tabname    varchar2(30);  /* имя таблицы ресурса */
    l_usercol    varchar2(30);  /* имя колонки пользователя */

    l_stmt       varchar2(4000);/* текст запроса */

    l_cno        t_chandle;     /* идентификатор курсора */
    l_rowcnt     number;

    l_resstate   number;

    begin

        bars_audit.trace('%s: entry point par[0]=>%s, par[1]=>%s par[2]=>...par[3]=>...', p, to_char(p_tipid), to_char(p_resid));

        -- получаем имя таблицы и имя колонки ид. пользователя
        begin
            select res_tipstabname, res_usercol
              into l_tabname, l_usercol
              from sec_resources
             where res_id = p_resid;
        end;
        bars_audit.trace('%s: res table %s, user col %s', p, l_tabname, l_usercol);

        -- конвертируем параметры во внутренюю структуру
        icnv_cols(p_resid, p_colnames, p_colvals, l_resrow);
        bars_audit.trace('%s: parameters converted to int storage', p);

        -- сразу удаляем
        l_stmt := 'delete from ' || l_tabname || ' where '  || l_usercol || ' = :tipid and ' ||
                  isvc_coltab2pair(l_resrow, ' and ');
        bars_audit.trace('%s: revoke stmt is %s', p, l_stmt);

        -- сообщение не требуется
        g_lastmsg := null;

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        dbms_sql.bind_variable(l_cno, 'tipid',  p_tipid);
        isvc_cbind(l_cno, l_resrow);

        -- Выполняем
        bars_audit.trace('%s: revoking resource...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row deleted.', p, to_char(l_rowcnt));

        -- Забираем ресурсы пользователей
        for s in ( select id from staff$base where tip = p_tipid )
        loop

            revoke_user_resource(
                  s.id,
                  p_resid,
                  p_colnames,
                  p_colvals );

        end loop;

        bars_audit.trace('%s: succ end', p);

    end revoke_stafftip_resource;


    -----------------------------------------------------------------
    -- ALTER_STAFFTIP_RESOURCE()
    --
    --     Процедура изменения параметров типовых пользователей
    --
    --     Параметры:
    --
    --         p_tipid      Ид. типового пользователя
    --
    --         p_resid      Ид. ресурса
    --
    --         p_pkcolnames Список имен столбцов перв. ключа
    --
    --         p_pkcolvals  Список значений столбцов перв. ключа
    --
    --         p_colnames   Список имен изменяемых реквизитов
    --
    --         p_colvals    Список значений изменяемых реквизитов
    --
    --
    procedure alter_stafftip_resource(
                  p_tipid      in  staff$base.tip%type,
                  p_resid      in  sec_resources.res_id%type,
                  p_pkcolnames in  t_varchar2list,
                  p_pkcolvals  in  t_varchar2list,
                  p_colnames   in  t_varchar2list,
                  p_colvals    in  t_varchar2list             )
    is

    p            constant varchar2(100)  := 'useradm.altusrtipres';

    l_tabname    varchar2(30);  /* имя таблицы ресурса */
    l_usercol    varchar2(30);  /* имя колонки пользователя */

    l_stmt       varchar2(4000);/* текст запроса */

    l_cno        t_chandle;     /* идентификатор курсора */
    l_rowcnt     number;

    l_respkrow   t_anyrow := t_anyrow();
    l_resrow     t_anyrow := t_anyrow();


    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s ...', p, to_char(p_tipid), to_char(p_resid));

        -- получаем имя таблицы и имя колонки ид. пользователя
        begin
            select res_tipstabname, res_usercol
              into l_tabname, l_usercol
              from sec_resources
             where res_id = p_resid;
        end;
        bars_audit.trace('%s: res table %s, user col %s', p, l_tabname, l_usercol);

        -- конвертируем параметры
        icnv_cols(p_resid, p_pkcolnames, p_pkcolvals, l_respkrow);
        icnv_cols(p_resid, p_colnames,   p_colvals,   l_resrow  );

        -- Формируем запрос для обновления
        l_stmt := 'update ' || l_tabname || ' set ' ||
                  isvc_coltab2pair(l_resrow, ', ')  ||
                  ' where ' || l_usercol || ' = :tipid and ' || isvc_coltab2pair(l_respkrow, ' and ');
        bars_audit.trace('%s: change stmt is %s', p, l_stmt);

        l_cno := isvc_cprep(l_stmt);

        -- Привязываем переменные
        isvc_cbind(l_cno, l_resrow);
        dbms_sql.bind_variable(l_cno, 'tipid',  p_tipid);
        isvc_cbind(l_cno, l_respkrow);

        -- Выполняем
        bars_audit.trace('%s: changing resource...', p);
        l_rowcnt := dbms_sql.execute(l_cno);
        dbms_sql.close_cursor(l_cno);
        bars_audit.trace('%s: %s row updated.', p, to_char(l_rowcnt));

        -- Обновляем ресурсы пользователей
        for s in ( select id from staff$base where tip = p_tipid )
        loop

            alter_user_resource(
                  s.id,
                  p_resid,
                  p_pkcolnames,
                  p_pkcolvals,
                  p_colnames,
                  p_colvals );

        end loop;

        bars_audit.trace('%s: succ end');

    end alter_stafftip_resource;

    --------------------------------------------------------
    -- CLONE_USER_FROM_STAFFTIP()
    --
    --     Процедура для передачи ресурсов пользователю
    --
    --
    --
    procedure clone_user_from_stafftip (
        p_srcTipId   in  staff$base.tip%type,
        p_dstUserId  in  staff$base.id%type,
        p_reslist    in  t_numberlist,
        p_resclone   in  t_numberlist,
        p_resclean   in  t_numberlist      )
    is

    p           constant varchar2(100)  := 'useradm.cloneusr';

    RES_CLONE   constant number(1)      := 1;
    RES_CLEAN   constant number(1)      := 1;

    l_tabname     sec_resources.res_tabname%type;  /* имя таблицы ресурса */
    l_tipstabname sec_resources.res_tipstabname%type;  /* имя таблицы ресурса */
    l_usercol     sec_resources.res_usercol%type;  /* имя столбца с ид. польз. */
    l_resaprstate sec_resources.res_approve%type;  /* признак подтверждаемого ресурса */
    l_resviewname sec_resources.res_grntviewname%type; /* */

    l_pkcol       varchar2(2000);
    l_tabcol      varchar2(2000);
    l_stmt        varchar2(4000);
    l_resapprove  number;
    l_resaproc    varchar2(90);

    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s...', p);

        if (nvl(to_number(get_param(PARAM_LOSEC)), 0) = PARAMV_LOSEC) then
            l_resapprove := USER_APPROVED;
        else
            l_resapprove := USER_NOTAPPROVED;
        end if;
        bars_audit.trace('%s: auto approve is %s', p, to_char(l_resapprove));

        -- Проходим по списку ресурсов
        for i in 1..p_reslist.count
        loop
            bars_audit.trace('%s: processing resource %s', p, to_char(p_reslist(i)));

            -- проверяем параметр необходимости клонирования ресурса
            if (p_resclone(i) = RES_CLONE) then

                -- получаем имя таблицы и имя колонки ид. пользователя, признак подтверждаемости
                begin
                    select res_tabname, res_tipstabname, res_usercol, res_approve, res_tipsgrntviewname, res_afterproc
                      into l_tabname, l_tipstabname, l_usercol, l_resaprstate, l_resviewname, l_resaproc
                      from sec_resources
                     where res_id = p_reslist(i);
                end;
                bars_audit.trace('%s: res table %s, user col %s, approve is %s', p, l_tabname, l_usercol, l_resaprstate);

                -- Очищаем
                if (p_resclean(i) = RES_CLEAN) then
                    execute immediate 'delete from ' || l_tabname || ' where ' || l_usercol || ' = :userid'
                    using p_dstuserid;
                    bars_audit.trace('%s: all user resources for this type deleted.', p);
                else

                    -- из БМД получаем первичный ключ представления
                    l_pkcol := null;
                    for c in (select colname
                                from meta_columns c, meta_tables t
                               where t.tabname = l_resviewname
                                 and t.tabid   = c.tabid
                                 and c.showretval = 1)
                    loop
                        l_pkcol := l_pkcol || ', ' || c.colname;
                    end loop;

                    l_pkcol := substr(l_pkcol, 2);
                    bars_audit.trace('%s: resource table pk is %s', p, l_pkcol);

                    l_stmt := 'delete from ' || l_tabname || ' where ' || l_usercol || ' = :dstuserid and  ('
                              || l_pkcol || ') in (select ' || l_pkcol || ' from ' || l_tipstabname ||
                              ' where ' || l_usercol || ' = :srctipid)';
                    bars_audit.trace('%s: clean res stmt is %s', p, l_stmt);

                    execute immediate l_stmt using p_dstuserid, p_srctipid;
                    bars_audit.trace('%s: resource cleaned.', p);

                end if;

                -- Получаем список столбцов
                l_tabcol := null;
                for c in (select column_name
                            from user_tab_columns
                           where table_name   = l_tabname
                             and column_name != l_usercol
                             and column_name not in ('APPROVE', 'REVOKED', 'GRANTOR', 'ADATE1', 'ADATE2', 'RDATE1', 'RDATE2', 'BRANCH'))
                loop
                    l_tabcol := l_tabcol || ',' || c.column_name;
                end loop;
                bars_audit.trace('%s: table cols %s',p, l_tabcol);

                -- Формируем запрос
                l_stmt := 'insert into ' || l_tabname || '(' || l_usercol || l_tabcol;
                if (l_resaprstate = RESOURCE_APPROVED) then
                    l_stmt := l_stmt || ', approve, grantor';
                end if;

                l_stmt := l_stmt || ') select :dstuserid ' || l_tabcol;
                if (l_resaprstate = RESOURCE_APPROVED) then
                    l_stmt := l_stmt || ', :approve, :grantor';
                end if;

                l_stmt := l_stmt || ' from ' || l_tipstabname || ' where ' || l_usercol || ' = :srctipid';
                bars_audit.trace('%s: clone stmt is %s', p, l_stmt);

                if (l_resaprstate = RESOURCE_APPROVED) then
                    execute immediate l_stmt
                    using p_dstuserid, l_resapprove, user_id, p_srctipid;
                else
                    execute immediate l_stmt
                    using p_dstuserid, p_srctipid;
                end if;
                bars_audit.trace('%s: clone stmt executed.', p);

                -- Выполняем пост-процедуру
                if (l_resaproc is not null) then
                    execute immediate 'begin ' || l_resaproc || '(:user_id); end;'
                    using p_dstuserid;
                end if;

            else
                bars_audit.trace('%s: resource %s skipped', p, to_char(p_reslist(i)));
            end if;

        end loop;

        -- формируем сообщение
        if (l_resapprove = USER_APPROVED) then
            g_lastmsg := bars_msg.get_msg(MODCODE, 'RESOURCE_NEED_APPROVE');
        else
            g_lastmsg := null;
        end if;

        bars_audit.trace('%s: succ end', p);

    end clone_user_from_stafftip;

    --------------------------------------------------------
    -- CLONE_STAFFTIP_TO_GROUP()
    --
    --     Процедура для передачи ресурсов пользователям
    --
    --
    --
    procedure clone_stafftip_to_group (
        p_srcTipId   in  staff$base.tip%type,
        p_reslist    in  t_numberlist,
        p_resclone   in  t_numberlist,
        p_resclean   in  t_numberlist      )
    is
    begin
        for s in ( select id from staff where tip = p_srcTipId and active = 1 )
        loop
            clone_user_from_stafftip(
                p_srcTipId,
                s.id,
                p_reslist,
                p_resclone,
                p_resclean );
        end loop;
    end clone_stafftip_to_group;

end bars_useradm;
/
 show err;
 
PROMPT *** Create  grants  BARS_USERADM ***
grant EXECUTE                                                                on BARS_USERADM    to ABS_ADMIN;
grant EXECUTE                                                                on BARS_USERADM    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_USERADM    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_useradm.sql =========*** End **
 PROMPT ===================================================================================== 
 