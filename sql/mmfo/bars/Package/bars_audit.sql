prompt package/bars_audit.sql
  CREATE OR REPLACE PACKAGE BARS.BARS_AUDIT 
is

    -------------------------------------------------------
    --
    --  Пакет для протоколирования работы комплекса
    --
    --
    --
    --
    --
    --
    --
     g_headerVersion   constant varchar2(64)  := 'version 1.08 07.06.2012';
     g_headerDefs      constant varchar2(512) := '';


    -------------------------------------------------------
    --
    -- Локальные типы
    --
    --
     type args is table of varchar2(2000);
     emptyArgs args;


    -------------------------------------------------------
    --
    -- Константы
    --
    --   Типы сообщений протокола
    --
    --
     LOG_LEVEL_TRACE      constant positive := 8;
     LOG_LEVEL_DEBUG      constant positive := 7;
     LOG_LEVEL_INFO       constant positive := 6;
     LOG_LEVEL_SECURITY   constant positive := 5;
     LOG_LEVEL_FINANCIAL  constant positive := 4;
     LOG_LEVEL_WARNING    constant positive := 3;
     LOG_LEVEL_ERROR      constant positive := 2;
     LOG_LEVEL_FATAL      constant positive := 1;

    --
    -- Режим вывода сообщений
    --
     OUTPUT_ON            constant number := 1;
     OUTPUT_OFF           constant number := 0;




    -------------------------------------------------------
    -- GET_MODULE()
    --
    --   Получение имени текущего имени модуля
    --
     function get_module return varchar2;


    -------------------------------------------------------
    -- SET_MODULE()
    --
    --   Установка имени текущего модуля
    --
     procedure set_module(
         p_module  in   varchar2);


    -------------------------------------------------------
    -- GET_MACHINE()
    --
    --   Функция получения установленного для текущей сессии
    --   имени машины  (для трехуровневой схемы работы)
    --
     function get_machine return varchar2;


    -------------------------------------------------------
    -- SET_MACHINE()
    --
    --   Процедура установки имени машины для текущей
    --   сессии (для трехуровневой схемы работы)
    --
    --
     procedure set_machine(
         p_machine  in   varchar2);

    -------------------------------------------------------
    -- GET_LOG_LEVEL()
    --
    --   Получить установленный уровень
    --   детализации протокола
    --
     function get_log_level return number;

    -------------------------------------------------------
    -- SET_LOG_LEVEL()
    --
    --   Процедура установки уровня протоколирования для
    --   текущей сессии
    --
     procedure set_log_level(
         p_loglevel in  number );


    -------------------------------------------------------
    -- GET_OUTPUT()
    --
    --   Получить установленный режим вывода сообщений
    --   с помощью dbms_output
    --
     function get_output return number;

    -------------------------------------------------------
    -- SET_OUTPUT()
    --
    --   Установить режим вывода сообщений
    --   с помощью dbms_output
    --
     procedure set_output(
         p_mode in  number );


    -------------------------------------------------------
    -- GET_TRACE_OBJECTS()
    --
    --   Получить список объектов для трассировки
    --
     function get_trace_objects return varchar2;

    -------------------------------------------------------
    -- SET_TRACE_OBJECTS()
    --
    --   Установить список объектов для трассировки
    --
     procedure set_trace_objects(
         p_traceobjs in  varchar2 );

    -------------------------------------------------------
    --
    --   Группа процедур для протоколирования работы
    --   при работе в двухуровневой архитектуре без
    --   возможности получения идентификатора записи
    --
    --   Входные параметры:
    --
    --      p_msg       текст сообщения
    --
    --
     procedure trace(
         p_msg     in  varchar2,
         p_arg1    in  varchar2  default null,
         p_arg2    in  varchar2  default null,
         p_arg3    in  varchar2  default null,
         p_arg4    in  varchar2  default null,
         p_arg5    in  varchar2  default null,
         p_arg6    in  varchar2  default null,
         p_arg7    in  varchar2  default null,
         p_arg8    in  varchar2  default null,
         p_arg9    in  varchar2  default null );

     procedure trace(
         p_msg     in  varchar2,
         p_args    in  args     );


     procedure debug(
         p_msg     in   varchar2);

     procedure info(
         p_msg     in   varchar2);

     procedure security(
         p_msg     in   varchar2);

     procedure financial(
         p_msg     in   varchar2);

     procedure warning(
         p_msg     in   varchar2);

     procedure error(
         p_msg     in   varchar2);

     procedure fatal(
         p_msg     in   varchar2);


    -------------------------------------------------------
    --
    -- Группа процедур для записи в журнал безопасности
    -- с возможностью указания имени машины для 3-х
    -- уровневой системы и возвратом идентификатора
    -- записи журнала безопасности
    --
    --   Входные параметры:
    --
    --      p_msg       Текст сообщения
    --
    --      p_module    Имя модуля, в котором происходит
    --                  вызов протоколирования
    --
    --      p_machine   Имя клиентской машины
    --                  При работе в трехуровневой архи-
    --                  тектуре необходимо передавать
    --                  имя машины, т.к. при такой работе
    --                  с БД работает сервер приложений
    --
    --   Выходные параметры:
    --
    --      p_recid     Идентификатор записи журнала
    --                  безопасности
    --


    -------------------------------------------------------
    -- TRACE()
    --
    --   Запись трассировочного сообщения в протокол
    --
     procedure trace(
         p_msg     in   varchar2,
         p_module  in   varchar2  default null,
         p_machine in   varchar2  default null,
         p_recid   out  number,
         p_arg1    in   varchar2  default null,
         p_arg2    in   varchar2  default null,
         p_arg3    in   varchar2  default null,
         p_arg4    in   varchar2  default null,
         p_arg5    in   varchar2  default null,
         p_arg6    in   varchar2  default null,
         p_arg7    in   varchar2  default null,
         p_arg8    in   varchar2  default null,
         p_arg9    in   varchar2  default null );

     procedure trace(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number,
         p_args    in   args     default emptyArgs);


    -------------------------------------------------------
    -- DEBUG()
    --
    --   Запись отладочного сообщения в протокол
    --
     procedure debug(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );


    -------------------------------------------------------
    -- INFO()
    --
    --   Запись информационного сообщения в протокол
    --
     procedure info(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );


    -------------------------------------------------------
    -- SECURITY()
    --
    --   Запись в протокол сообщения безопасности
    --
     procedure security(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );

    -------------------------------------------------------
    -- FINANCIAL()
    --
    --   Запись финансового сообщения в протокол
    --
     procedure financial(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );



    -------------------------------------------------------
    -- WARNING()
    --
    --   Запись предупреждения в протокол
    --
     procedure warning(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );



    -------------------------------------------------------
    -- ERROR()
    --
    --   Запись сообщение об ошибке в протокол
    --
     procedure error(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );




    -------------------------------------------------------
    -- FATAL()
    --
    --   Запись сообщения о критической ошибке в протокол
    --
     procedure fatal(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );







    -------------------------------------------------------
    --                                                   --
    --  Общие процедуры для записи сообщений             --
    --                                                   --
    -------------------------------------------------------


    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    Запись в журнал аудита сообщения заданного типа
    --
    --
     procedure write_message(
         p_eventType   in  sec_audit.rec_type%type,
         p_bankDate    in  sec_audit.rec_bdate%type,
         p_message     in  sec_audit.rec_message%type );


    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    Запись в журнал аудита сообщения заданного типа
    --    с указанием имени машины клиента
    --
    --    Используется в 3-х звенной архитектуре, где
    --    клиентская машина не может быть определена
    --    сервером БД
    --
     procedure write_message(
         p_eventType   in  sec_audit.rec_type%type,
         p_bankDate    in  sec_audit.rec_bdate%type,
         p_message     in  sec_audit.rec_message%type,
         p_machine     in  sec_audit.machine%type     );


    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    Запись в журнал аудита сообщения заданного типа
    --
    --
     procedure write_message(
         p_eventType   in  positive,
         p_bankDate    in  sec_audit.rec_bdate%type,
         p_message     in  sec_audit.rec_message%type );

    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    Запись в журнал аудита сообщения заданного типа
    --    Метод специально для Centura
    --
       procedure write_message_aux(
           p_eventType   in  sec_audit.rec_type%type,
           p_bankDate    in  sec_audit.rec_bdate%type,
           p_message     in  sec_audit.rec_message%type );



    --------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    --
    function header_version return varchar2;

    --------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2;


    -------------------------------------------------------
    --
    -- Устаревшие константы уровня протоколирования
    --
    --
    --
     DEB_MSG              constant positive := 7;
     INFO_MSG             constant positive := 6;
     FIN_MSG              constant positive := 4;
     WARN_MSG             constant positive := 3;
     ERR_MSG              constant positive := 2;


    --------------------------------------------------------
    -- TRACE_ENABLED()
    --
    --     Функция возвращает true/false -
    --     признак включения трассировки
    --
    --
    function trace_enabled return boolean;

    --------------------------------------------------------
    -- CLEAR_SESSION_CONTEXT
    --
    --     Очистка сессионного контекста
    --
    --
    procedure clear_session_context;

    --------------------------------------------------------
    -- DISCARD_TRACING
    --
    --     Сбрасываем трассировку сессий по истечению времени
    --     в параметре TRACEDAY
    --
    --
    procedure discard_tracing;

    procedure log_trace(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false);

    procedure log_debug(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false);

    procedure log_info(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false);

    procedure log_security(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false);

    procedure log_financial(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false);

    procedure log_warning(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false);

    procedure log_error(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false);

    procedure log_fatal(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_AUDIT 
is


     g_bodyVersion   constant varchar2(64)  := 'version 1.25 02.10.2018';
     g_bodyDefs      constant varchar2(512) := ''
              || '          для всех банков'       || chr(10)

;

    -------------------------------------------------------
    -- Внутренние константы пакета
    --
    --
     MAX_MODULE_LEN       constant positive := 30;
     MAX_OBJECT_LEN       constant positive := 100;
     MAX_RECTYPE_LEN      constant positive := 10;
     MAX_MESSAGE_LEN      constant positive := 4000;
     MAX_MACHINE_LEN      constant positive := 255;

     MODULE_PREFIX        constant varchar2(3) := 'SEC';


    -------------------------------------------------------
    -- Внутренние переменные пакета
    --
    --
    --
    g_alarmlist    varchar2(2000);  /*  список типов сообщений для уведомления */
    g_alarmLoaded  boolean;         /* признак загрузки списка типов сообщений */
    g_moduleName   varchar2(30);    /*       установленное имя текущего модуля */
    g_machineName  varchar2(255);   /*     установленное имя клиентской машины */
    g_trcObject    varchar2(2000);  /*         список объектов для трассировки */
    g_absUserID    number;          /*  идентификатор пользователя в комплексе */
    g_userBranch   varchar2(30);    /*          код подразделения пользователя */
    g_logLevel     number;          /*             текущий уровень детализации */
    g_isPkgDebug   boolean;         /*              признак внутренней отладки */
    g_isSaveStack  boolean;         /*         признак сохранения стека вызова */
    g_output       number;          /*    признак вывода сообщений dbms_output */





    -------------------------------------------------------
    -- GET_LEVEL_ID()
    --
    --   Получение константы по символьному значению
    --   типа сообщения
    --
    --
     function get_level_id(
         p_levelName  in varchar2) return number
     is

     l_logLevel   number;

     begin

         if    (p_levelName = 'FATAL'    )  then l_logLevel := LOG_LEVEL_FATAL;
         elsif (p_levelName = 'ERROR'    )  then l_logLevel := LOG_LEVEL_ERROR;
         elsif (p_levelName = 'WARNING'  )  then l_logLevel := LOG_LEVEL_WARNING;
         elsif (p_levelName = 'FINANCIAL')  then l_logLevel := LOG_LEVEL_FINANCIAL;
         elsif (p_levelName = 'SECURITY' )  then l_logLevel := LOG_LEVEL_SECURITY;
         elsif (p_levelName = 'INFO'     )  then l_logLevel := LOG_LEVEL_INFO;
         elsif (p_levelName = 'DEBUG'    )  then l_logLevel := LOG_LEVEL_DEBUG;
         elsif (p_levelName = 'TRACE'    )  then l_logLevel := LOG_LEVEL_TRACE;
         else
             bars_error.raise_error(MODULE_PREFIX, 701, p_levelName);
         end if;

         return l_logLevel;

     end get_level_id;


    -------------------------------------------------------
    -- GET_LEVEL_NAME()
    --
    --   Получение символьного значения типа сообщения
    --   по его цифровой константе
    --
    --
     function get_level_name(
         p_level_id   in  number ) return varchar2
     is

     l_levelName    sec_audit.rec_type%type;

     begin


         if    (p_level_id = LOG_LEVEL_FATAL    ) then l_levelName := 'FATAL';
         elsif (p_level_id = LOG_LEVEL_ERROR    ) then l_levelName := 'ERROR';
         elsif (p_level_id = LOG_LEVEL_WARNING  ) then l_levelName := 'WARNING';
         elsif (p_level_id = LOG_LEVEL_FINANCIAL) then l_levelName := 'FINANCIAL';
         elsif (p_level_id = LOG_LEVEL_SECURITY ) then l_levelName := 'SECURITY';
         elsif (p_level_id = LOG_LEVEL_INFO     ) then l_levelName := 'INFO';
         elsif (p_level_id = LOG_LEVEL_DEBUG    ) then l_levelName := 'DEBUG';
         elsif (p_level_id = LOG_LEVEL_TRACE    ) then l_levelName := 'TRACE';
         else
             bars_error.raise_error(MODULE_PREFIX, 701, 'Id=' || to_char(p_level_id));
         end if;

         return l_levelName;

     end get_level_name;






    -------------------------------------------------------
    -- LOAD_ALARM()
    --
    --    Процедура загружает список типов сообщений при
    --    возникновении которых необходимо ставить их в
    --    очередь уведомлений
    --
    --
     procedure load_alarm
     is
     begin

         if (sys_context('bars_audit', 'alarm_list') is not null) then
             g_alarmlist := sys_context('bars_audit', 'alarm_list');
             if (g_alarmlist = '<NULL>') then g_alarmLoaded := false;
             else                             g_alarmLoaded := true;
             end if;
         end if;

         g_alarmLoaded := false;
         g_alarmlist   := null;

         for c in (select sec_rectype from sec_rectype where sec_alarm = 'Y')
         loop
             g_alarmlist := g_alarmlist || ' ' || c.sec_rectype;
         end loop;

         if (g_alarmList is not null) then
             g_alarmLoaded := true;
         end if;

         -- Сохраняем значения в контексте
         if (g_alarmloaded) then
             sys.dbms_session.set_context('bars_audit', 'alarm_list', g_alarmlist, client_id=>sys_context('userenv', 'client_identifier'));
         else
             sys.dbms_session.set_context('bars_audit', 'alarm_list', '<NULL>',    client_id=>sys_context('userenv', 'client_identifier'));
         end if;

     end load_alarm;




    -------------------------------------------------------
    -- LOAD_LOG_LEVEL()
    --
    --   Установка пользовательского уровня
    --   детализации протокола
    --
    --
    procedure load_log_level
    is
    --
    l_logLevelName   sec_useraudit.log_level%type;
    l_trcObject      sec_useraudit.trace_object%type;
    l_trcStack       sec_useraudit.trace_stack%type;
    --
    begin

        -- Если данные уже есть в контексте, то читаем оттуда
        if (sys_context('bars_audit', 'log_level') is not null) then

            g_absUserid   := nvl(to_number(sys_context('bars_global', 'user_id')), -1);
            g_logLevel    := sys_context('bars_audit', 'log_level');
            g_trcObject   := sys_context('bars_audit', 'trace_objects');
            if (sys_context('bars_audit', 'trace_stack') is not null) then g_isSaveStack := true;
            else                                                           g_isSaveStack := false;
            end if;

            return;

        end if;

        begin
            g_absuserid := nvl(to_number(sys_context('bars_global', 'user_id')), -1);

            select a.log_level, a.trace_object, a.trace_stack
              into l_logLevelName, l_trcObject, l_trcStack
              from staff$base s, sec_useraudit a
             where s.id = g_absuserid
               and s.id = a.staff_id;

            g_logLevel  := get_level_id(l_logLevelName);
            g_trcObject := l_trcObject;

            if (l_trcStack = 1) then
                g_isSaveStack := true;
            else
                g_isSaveStack := false;
            end if;

        exception
            when NO_DATA_FOUND then

                begin

                    select log_level, trace_object, trace_stack
                      into l_logLevelName, l_trcObject, l_trcStack
                      from sec_useraudit
                     where staff_id = -1;

                    g_logLevel  := get_level_id(l_logLevelName);
                    g_trcObject := l_trcObject;

                    if (l_trcStack = 1) then
                        g_isSaveStack := true;
                    else
                        g_isSaveStack := false;
                    end if;

                exception
                    when NO_DATA_FOUND then
                        g_logLevel    := LOG_LEVEL_INFO;
                        g_trcObject   := null;
                        g_isSaveStack := false;
                end;
         end;

         -- Сохраняем параметры в контексте
         sys.dbms_session.set_context('bars_audit', 'log_level',     to_char(g_logLevel), client_id=>sys_context('userenv', 'client_identifier'));
         sys.dbms_session.set_context('bars_audit', 'trace_objects', g_trcObject,         client_id=>sys_context('userenv', 'client_identifier'));
         --
         if (g_isSaveStack)
         then
             sys.dbms_session.set_context('bars_audit', 'trace_stack', 'TRUE',            client_id=>sys_context('userenv', 'client_identifier'));
         end if;

     end load_log_level;



    -------------------------------------------------------
    --
	-- LOAD_PARAM()
    --
    --   Загружаем умолчательные параметры
    --
     procedure load_param
     is
     begin

         set_module(p_module => null);
         load_alarm();
         load_log_level();

         g_isPkgDebug := false;

         if sys_context('bars_audit', 'dbms_output') is not null
         then
            g_output := to_number(sys_context('bars_audit', 'dbms_output'));
         else
            g_output := OUTPUT_OFF;
         end if;

         -- включаем вывод на консоль, если задана переменная g_output
         if g_output = OUTPUT_ON
         then
            dbms_output.enable(null);
         end if;
         --
     end load_param;



    -------------------------------------------------------
    -- WRITE_ALARM()
    --
    --    Процедура отсылки оповещения об ошибке
    --
    --
    --
    procedure write_alarm(
                  p_rectype  in  sec_audit.rec_type%type,
                  p_recmsg   in  sec_audit.rec_message%type,
                  p_recdate  in  sec_audit.rec_date%type,
                  p_recbdate in  sec_audit.rec_bdate%type,
                  p_recuid   in  sec_audit.rec_uid%type,
                  p_recsrc   in  sec_audit.machine%type    )
    is

    l_result  number;

    begin

        if (g_alarmlist like '%' || p_rectype || '%') then

                begin
                    execute immediate 'begin bars_alerter_push_msg(:result, :channel, :msgn, :msgtxt, :msgtype, :msgdate, :msgsrc); end;'
                    using out l_result, 'SEC_WATCHER', 0, p_recmsg, p_rectype,
                    to_char(p_recdate, 'dd/mm/yyyy hh24:mi:ss') || '@' || to_char(p_recbdate, 'dd/mm/yyyy'),
                    to_char(p_recuid) || '@' || p_recsrc;
                end;

        end if;

    end write_alarm;







    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    Процедура записи данных в журнал безопасности
    --
    --    ! Основная процедура работы с журналом !
    --
    --
     procedure write_message(
         p_rectype     in  sec_audit.rec_type%type,
         p_module      in  sec_audit.rec_module%type,
         p_object      in  sec_audit.rec_object%type  default null,
         p_machine     in  sec_audit.machine%type,
         p_msg         in  sec_audit.rec_message%type,
         p_stack       in  sec_audit.rec_stack%type default null,
         p_recid       out sec_audit.rec_id%type)
     is
     pragma autonomous_transaction;

         l_rectype     sec_audit.rec_type%type;
         l_recmodule   sec_audit.rec_module%type;
         l_recobject   sec_audit.rec_object%type;
         l_recdate     sec_audit.rec_date%type;
         l_recbdate    sec_audit.rec_bdate%type;
         l_message     sec_audit.rec_message%type;
         l_machine     sec_audit.machine%type;

         l_appModule   varchar2(48);        /* имя модуля устан. через dbms_application_info */
         l_appAction   varchar2(32);        /*   действие устан. через dbms_application_info */

         guard_error   exception;
         pragma exception_init(guard_error, -16224);

     begin

         --
         -- Проверяем детализацию протоколирования
         --
         if (g_logLevel < get_level_id(p_rectype)) then
             p_recid := -1;
             return;
         end if;


         l_rectype   := substr(p_rectype, 1, MAX_RECTYPE_LEN);
         l_recdate   := sysdate;
         l_message   := substr(p_msg,     1, MAX_MESSAGE_LEN);
         l_recobject := substr(p_object,  1, MAX_OBJECT_LEN );

         --
         -- Имя модуля либо передается, либо берется
         -- установленное с помощью SET_MODULE имя
         --
         if    (p_module is not null) then
             l_recmodule := substr(p_module,  1, MAX_MODULE_LEN);
         elsif (g_moduleName is not null) then
             l_recmodule := g_moduleName;
         else
             dbms_application_info.read_module(l_appModule, l_appAction);
             l_recmodule := substr(l_appModule, 1, MAX_MODULE_LEN);
         end if;

         --
         -- Определяем банковскую дату
         -- Банковская дата пользователя определяется
         -- в контексте BARS_GL. Если значение на данный
         -- момент не определено (не было вызова пакета GL),
         -- то берем глобальную банковскую дату из BARS_CONTEXT
         --
         begin
             l_recbdate  := to_date(sys_context('bars_gl', 'bankdate'), 'mm/dd/yyyy');
         exception
             when OTHERS then
                 begin
                     l_recbdate  := to_date(sys_context('bars_gl', 'bankdate'), 'mm-dd-yyyy');
                 exception
                     when OTHERS then null;
                 end;
         end;

         if (l_recbdate is null) then
             l_recbdate  := to_date(sys_context('bars_context', 'global_bankdate'), 'mm/dd/yyyy');
         end if;

         -- Имя машины устанавливается в контексте
         l_machine := substr(nvl(g_machinename, sys_context('bars_global', 'host_name'))||'('||sys_context('USERENV', 'IP_ADDRESS')||')', 1, MAX_MACHINE_LEN);

         -- Отдельно для заданий имя машины
         if(l_machine is null and sys_context('userenv', 'bg_job_id') is not null) then
             l_machine := 'LOCALHOST';
         end if;

         -- Это для обхода bug в версии 9.2.0.4
         if (l_machine is null) then
             l_machine := 'NOT AVAILABLE';
         end if;

         -- Вставляем запись в журнал аудита
         insert into sec_audit(
             rec_id,
             rec_uid,
             rec_userid,
             rec_uname,
             rec_uproxy,
             rec_type,
             rec_module,
             rec_object,
             rec_date,
             rec_bdate,
             rec_message,
             rec_stack,
             machine,
             client_identifier )
         values(
             s_secaudit.nextval,
             nvl(to_number(sys_context('bars_global', 'user_id')), -1),
             sys_context('userenv', 'session_userid'),
             nvl(sys_context('bars_global', 'user_name'), 'UNKNOWN'),
             sys_context('userenv', 'proxy_user'),
             l_rectype,
             l_recmodule,
             l_recobject,
             l_recdate,
             l_recbdate,
             l_message,
             p_stack,
             l_machine,
             sys_context('userenv', 'client_identifier') )
          returning rec_id into p_recid;

         --
         -- Если включен режим уведомления,
         -- то необходимо вставлять уведомление
         --
         if (g_alarmLoaded) then

             write_alarm(
                  p_rectype  => l_rectype,
                  p_recmsg   => l_message,
                  p_recdate  => l_recdate,
                  p_recbdate => l_recbdate,
                  p_recuid   => g_absUserID,
                  p_recsrc   => l_machine   );

         end if;

         commit;

         --
         -- Если включен вывод в dbms_output, то формируем сообщение
         --
         if (g_output = OUTPUT_ON) then
             dbms_output.put_line(substr('AUDIT: ' || rpad(l_rectype, 10, ' ') || l_message, 1, 250));
         end if;
     exception
         when GUARD_ERROR then commit;
     end write_message;




    -------------------------------------------------------
    -- GET_MODULE()
    --
    --   Получение имени текущего имени модуля
    --
     function get_module return varchar2
     is
     begin
         return g_moduleName;
     end get_module;


    -------------------------------------------------------
    -- SET_MODULE()
    --
    --   Установка имени текущего модуля
    --
     procedure set_module(
         p_module  in   varchar2)
     is
     begin
         g_moduleName := substr(p_module, 1, MAX_MODULE_LEN);
     end set_module;



    -------------------------------------------------------
    -- GET_MACHINE()
    --
    --   Функция получения установленного для текущей сессии
    --   имени машины  (для трехуровневой схемы работы)
    --
     function get_machine return varchar2
     is
     begin
         return g_machineName;
     end get_machine;


    -------------------------------------------------------
    -- SET_MACHINE()
    --
    --   Процедура установки имени машины для текущей
    --   сессии (для трехуровневой схемы работы)
    --
    --
     procedure set_machine(
         p_machine  in   varchar2)
     is
     begin
         g_machineName := substr(p_machine, 1, MAX_MACHINE_LEN);
     end set_machine;


    -------------------------------------------------------
    -- GET_LOG_LEVEL()
    --
    --   Получить установленный уровень
    --   детализации протокола
    --
     function get_log_level return number
     is
     begin

         return g_logLevel;

     end get_log_level;

    -------------------------------------------------------
    -- SET_LOG_LEVEL()
    --
    --   Процедура установки уровня протоколирования для
    --   текущей сессии
    --
     procedure set_log_level(
         p_loglevel in  number )
     is

     l_levelname  sec_audit.rec_type%type;  /* имя типа сообщения */

     begin

         -- для проверки корректности уровня
         l_levelname := get_level_name(p_loglevel);
         -- пишем в переменную
         g_logLevel := p_loglevel;
         -- а также в контекст
         sys.dbms_session.set_context('bars_audit', 'log_level',     to_char(g_logLevel), client_id=>sys_context('userenv', 'client_identifier'));

     end set_log_level;

    -------------------------------------------------------
    -- GET_OUTPUT()
    --
    --   Получить установленный режим вывода сообщений
    --   с помощью dbms_output
    --
     function get_output return number
     is
     begin
         return g_output;
     end get_output;

    -------------------------------------------------------
    -- SET_OUTPUT()
    --
    --   Установить режим вывода сообщений
    --   с помощью dbms_output
    --
     procedure set_output(
         p_mode in  number )
     is
     begin

         if (p_mode not in (OUTPUT_ON, OUTPUT_OFF)) then
               g_output := OUTPUT_OFF;
         end if;

         g_output := p_mode;

         -- пишем в контекст
         sys.dbms_session.set_context('bars_audit', 'dbms_output', to_char(g_output), client_id=>sys_context('userenv', 'client_identifier'));

         -- включаем вывод на консоль, если задана переменная g_output
         if g_output = OUTPUT_ON
         then
            dbms_output.enable(null);
         end if;
         --

     end set_output;


  -------------------------------------------------------
  -- GET_TRACE_OBJECTS()
  --
  --   Получить список объектов для трассировки
  --
   function get_trace_objects return varchar2
   is
   begin
       --
       return g_trcObject;
       --
   end get_trace_objects;

  -------------------------------------------------------
  -- SET_TRACE_OBJECTS()
  --
  --   Установить список объектов для трассировки
  --
   procedure set_trace_objects(
       p_traceobjs in  varchar2 )
   is
   begin
       g_trcObject := p_traceobjs;
       --
       sys.dbms_session.set_context('bars_audit', 'trace_objects', g_trcObject,         client_id=>sys_context('userenv', 'client_identifier'));
       --
   end set_trace_objects;


   -------------------------------------------------------------------
   -- GET_OBJECT()
   --
   --     По состоянию стека, процедура возвращает схему, имя объекта
   --     и номер строки, откуда был произведен вызов пакета трасси-
   --     ровки
   --
    function get_object return varchar2
    is

    --
    -- Уровень вложенности, зависит от внутренней реализации
    -- вызовов в пакете. Текущая реализация вызовов:
    --
    --   USER MODULE -> BARS_AUDIT.TRACE         ->
    --                  BARS_AUDIT.GET_OBJECT
    --
    -- Таким обрабом модуль, который вызывает пакет трассировки
    -- стоит третьим
    --

    CL_FIRST_CALLER  constant number := 3;


    l_stack       varchar2(4096) default dbms_utility.format_call_stack;
    l_line        varchar2(4000);
    l_linesep     number;
    l_stackFound  boolean        default false;
    l_callerLevel number         default 0;

    l_owner       varchar2(30);
    l_object      varchar2(30);
    l_lineno      number;

    begin

        -- отладка
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.GET_OBJECT: proc entry point');
        end if;

        --
        -- В переменную L_STACK мы получаем текущий стек.
        -- Стек представляет собой строку до 2К след. вида:
        --
        --        ----- PL/SQL Call Stack -----
        --    object      line  object
        --    handle    number  name
        --  6D637684         1  anonymous block
        --
        -- Таким образом стек состоит из заголовка и собственно
        -- стека вызовов. Сначало мы находим строку содержащую
        -- последнюю строку заголовка, далее пропускаем кол-во
        -- строк, указанной в константе CL_FIRST_CALLER, и сле-
        -- дующая строка будет содержать информацию о вызывавшем
        -- нас объекте
        --

        -- отладка
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.GET_OBJECT: begin stack parsing');
        end if;


        loop

            --
            -- выделяем строку по символу перевода строки. Если
            -- символа перевода строки нет, то выходим. Выходим
            -- и в том случае, если глубина вложения стека уже
            -- больше, чем требуемый уровень вложенности
            --
            l_linesep := instr(l_stack, chr(10));
            exit when (l_callerLevel = CL_FIRST_CALLER+1 or l_linesep is null or l_linesep = 0);

            -- выделили строку, уменьшили буфер исходного стека
            l_line  := substr(l_stack, 1, l_linesep-1);
            l_stack := substr(l_stack, l_linesep+1);

            if (not l_stackFound) then

                if (l_line like '%handle%number%name%') then

                    -- отладка
                    if (g_isPkgDebug) then
                        dbms_output.put_line('BARS_AUDIT.GET_OBJECT: stack hdr end line found');
                    end if;

                    l_stackFound := true;
                end if;

            else

                l_callerLevel := l_callerLevel + 1;

                if (l_callerLevel = CL_FIRST_CALLER) then

                    -- отладка
                    if (g_isPkgDebug) then
                        dbms_output.put_line('BARS_AUDIT.GET_OBJECT: caller stack line found at ' || to_char(l_callerLevel));
                        dbms_output.put_line('BARS_AUDIT.GET_OBJECT: caller stack line="' || l_line || '"');
                        dbms_output.put_line('BARS_AUDIT.GET_OBJECT: begin stack line parsing');
                    end if;

                    -- search LineNo position
                    l_line   := ltrim(substr(l_line, instr(l_line, ' ')));
                    l_lineno := to_number(substr(l_line, 1, instr(l_line, ' ')));

                    -- search object position
                    l_line := ltrim(substr(l_line, instr(l_line, ' ')));
                    l_line := ltrim(substr(l_line, instr(l_line, ' ')));

                    if (l_line like 'block%' or l_line like 'body%') then
                        l_line := ltrim(substr(l_line, instr(l_line, ' ')));
                    end if;

                    l_owner  := ltrim(rtrim(substr(l_line, 1, instr(l_line, '.') - 1)));
                    l_object := ltrim(rtrim(substr(l_line, instr(l_line, '.') + 1)));

                    if (l_owner is null) then
                        l_owner  := user;
                        l_object := 'ANONYMOUS BLOCK';
                    end if;

                    -- отладка
                    if (g_isPkgDebug) then
                        dbms_output.put_line('BARS_AUDIT.GET_OBJECT: stack line parsed');
                    end if;

                end if;

            end if;

        end loop;

        -- отладка
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.GET_OBJECT: stack parsed');
            dbms_output.put_line('BARS_AUDIT.GET_OBJECT: owner="' || l_owner   || '"');
            dbms_output.put_line('BARS_AUDIT.GET_OBJECT: object="' || l_object || '"');
            dbms_output.put_line('BARS_AUDIT.GET_OBJECT: lineno=' || to_char(l_lineno));
        end if;

--        return substr(l_owner || '.' || l_object || ':' || to_char(l_lineno), 1, 100);
        return substr(l_owner || '.' || l_object, 1, 100);

    end get_object;


   ------------------------------------------------------------------
   -- PRINTF()
   --
   --     Процедура форматирования строки сообщения. Если в строку
   --     включены описания, то производится подстановка переданных
   --     аргументов в строку сообщения
   --
   --
    function printf(
        p_message  in varchar2,
        p_args     in args     ) return varchar2
    is

    l_src     varchar2(4000);
    l_message varchar2(4000);
    l_argc    number;                      -- количество элементов массива
    l_argn    number           default 1;  -- текущий элемент массива
    l_pos     number           default 0;

    begin

        -- отладка
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: proc entry point'                                 );
            dbms_output.put_line('BARS_AUDIT.PRINTF: proc arg[0]="' || substr(p_message, 1, 200) || '"');
            for i in p_args.first..p_args.last
            loop
                dbms_output.put_line('BARS_AUDIT.PRINTF: proc arg[2,' || to_char(i) || ']="' || p_args(i) || '"');
            end loop;
        end if;

        --
        -- Ищем в строке сообщения (p_message) символ % или \, как
        -- возможный указатель на место подстановки аргумента или
        -- символа перевода строки. Если в строке нет ни одного из
        -- таких символов, то ничего с строкой сообщения делать не
        -- нужно - просто вернуть исходную строку сообщения
        --

        if (instr(p_message, '%') = 0 and instr(p_message, '\') = 0 ) then

            -- отладка
            if (g_isPkgDebug) then
                dbms_output.put_line('BARS_AUDIT.PRINTF: specifications not found. Return original message');
                dbms_output.put_line('BARS_AUDIT.PRINTF: return message="' || substr(p_message, 1, 200) || '"');
            end if;

           return p_message;
        end if;

        -- отладка
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: begin parsing');
        end if;

        --
        -- Получаем кол-во аргументов и строку для разбора
        --
        l_argc := p_args.count;
        l_src  := p_message;

        --
        -- Ищем и образатываем указатели на подстановку аргументов
        --

        -- отладка
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: replacing %s specification');
        end if;

        loop

            --
            -- получаем первую позицию символа %s
            --
            l_pos := instr(l_src, '%s');

            -- отладка
            if (g_isPkgDebug) then
                dbms_output.put_line('BARS_AUDIT.PRINTF: arg spec at pos ' || to_char(l_pos));
            end if;

            --
            -- Выходим, если символа нет (0, null) или уже
            -- подставили все возможные аргументы
            --
            exit when (l_pos = 0 or l_pos is null or l_argn > l_argc);

            --
            -- Переносим часть до указателя и текущий аргумент
            -- в выходное сообщение
            --
            l_message := substr(l_message || substr(l_src, 1, l_pos-1) || p_args(l_argn), 1, 4000);
            l_src     := substr(l_src, l_pos+2);
            l_argn    := l_argn + 1;


            -- отладка
            if (g_isPkgDebug) then
                dbms_output.put_line('BARS_AUDIT.PRINTF: msg="' || l_message || '"');
            end if;

        end loop;

        -- отладка
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: replacing %s specification complete');
        end if;

        --
        -- Переносим полученный текст сообщения в исходное
        -- и начинаем поиск символов перевода строки
        --
        l_src     := substr(l_message || l_src, 1, 4000);
        l_message := null;

        --
        -- Ищем и обрабатываем указатели перевода строки
        --

        -- отладка
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: searching \n specification');
        end if;


        loop
            --
            -- получаем первую позицию символов \n
            --
            l_pos := instr(l_src, '\n');

            -- отладка
            if (g_isPkgDebug) then
                dbms_output.put_line('BARS_AUDIT.PRINTF: endline spec at pos ' || to_char(l_pos));
            end if;

            --
            -- Выходим, если символов нет (0, null)
            --
            exit when (l_pos = 0 or l_pos is null);

            l_message := substr(l_message || substr(l_src, 1, l_pos-1) || chr(10), 1, 4000);
            l_src := substr(l_src, l_pos+2);

        end loop;

        -- отладка
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: replacing \n specification complete');
        end if;

        --
        -- Переносим оставшийся кусок исходного сообщения
        --
        l_message := substr(l_message || l_src, 1, 4000);

        -- отладка
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: end parsing');
            dbms_output.put_line('BARS_AUDIT.PRINTF: ret msg="' || l_message || '"');
        end if;

        return l_message;

    end printf;




































    -------------------------------------------------------
    -- TRACE()
    --
    --   Запись трассировочного сообщения в протокол
    --
    --
     procedure trace(
         p_msg  in  varchar2,
         p_arg1 in  varchar2  default null,
         p_arg2 in  varchar2  default null,
         p_arg3 in  varchar2  default null,
         p_arg4 in  varchar2  default null,
         p_arg5 in  varchar2  default null,
         p_arg6 in  varchar2  default null,
         p_arg7 in  varchar2  default null,
         p_arg8 in  varchar2  default null,
         p_arg9 in  varchar2  default null )
     is

     l_recid   number(38);
     l_msg     sec_audit.rec_message%type;
     l_object  varchar2(100);

     begin

          if (g_logLevel < LOG_LEVEL_TRACE) then
              return;
          end if;

          l_object := get_object();

          if (g_trcObject = 'ALL'
              or instr(',' || g_trcObject || ',', ',' || l_object || ',') !=0) then
                 null;
          else
              return;
          end if;

          -- обрабатываем параметры
          l_msg := printf(p_msg,args(substr(p_arg1, 1, 2000),
                                     substr(p_arg2, 1, 2000),
                                     substr(p_arg3, 1, 2000),
                                     substr(p_arg4, 1, 2000),
                                     substr(p_arg5, 1, 2000),
                                     substr(p_arg6, 1, 2000),
                                     substr(p_arg7, 1, 2000),
                                     substr(p_arg8, 1, 2000),
                                     substr(p_arg9, 1, 2000) ));

          write_message(
               p_rectype  => 'TRACE',
               p_module   => null,
               p_object   => l_object,
               p_machine  => null,
               p_msg      => l_msg,
               p_stack    => dbms_utility.format_call_stack,
               p_recid    => l_recid  );

     end trace;


    -------------------------------------------------------------------
    -- TRACE()
    --
    --    Запись трассировочного сообщения в протокол
    --
    --
     procedure trace(
         p_msg  in  varchar2,
         p_args in  args     )
     is

     l_recid   number(38);
     l_object  varchar2(100);

     begin

         if (g_logLevel < LOG_LEVEL_TRACE) then
             return;
         end if;

          l_object := get_object();

          if (g_trcObject = 'ALL'
              or instr(',' || g_trcObject || ',', ',' || l_object || ',') !=0) then
                 null;
          else
              return;
          end if;

         write_message(
              p_rectype  => 'TRACE',
              p_module   => null,
              p_object   => l_object,
              p_machine  => null,
              p_msg      => printf(p_msg, p_args),
              p_stack    => dbms_utility.format_call_stack,
              p_recid    => l_recid  );

     end trace;



    -------------------------------------------------------
    -- DEBUG()
    --
    --   Запись отладочного сообщения в протокол
    --
     procedure debug(
         p_msg    in   varchar2)
     is

     l_recid   number(38);

     begin

         write_message(
             p_rectype  => 'DEBUG',
             p_module   => null,
             p_machine  => null,
             p_msg      => p_msg,
             p_stack    => null,
             p_recid    => l_recid  );

     end debug;

    -------------------------------------------------------
    -- INFO()
    --
    --   Запись информационного сообщения в протокол
    --
     procedure info(
         p_msg    in   varchar2)
     is

     l_recid   number(38);

     begin

         write_message(
             p_rectype  => 'INFO',
             p_module   => null,
             p_machine  => null,
             p_msg      => p_msg,
             p_recid    => l_recid  );

     end info;

    -------------------------------------------------------
    -- SECURITY()
    --
    --   Запись в протокол сообщения безопасности
    --
     procedure security(
         p_msg    in   varchar2)
     is

     l_recid   number(38);

     begin

         write_message(
             p_rectype  => 'SECURITY',
             p_module   => null,
             p_machine  => null,
             p_msg      => p_msg,
             p_recid    => l_recid  );

     end security;

    -------------------------------------------------------
    -- FINANCIAL()
    --
    --   Запись финансового сообщения в протокол
    --
     procedure financial(
         p_msg    in   varchar2)
     is

     l_recid   number(38);

     begin

         write_message(
             p_rectype  => 'FINANCIAL',
             p_module   => null,
             p_machine  => null,
             p_msg      => p_msg,
             p_recid    => l_recid  );

     end financial;


    -------------------------------------------------------
    -- WARNING()
    --
    --   Запись предупреждения в протокол
    --
     procedure warning(
         p_msg    in   varchar2)
     is

     l_recid   number(38);

     begin

         write_message(
             p_rectype  => 'WARNING',
             p_module   => null,
             p_machine  => null,
             p_msg      => p_msg,
             p_recid    => l_recid  );

     end warning;



    -------------------------------------------------------
    -- ERROR()
    --
    --   Запись сообщение об ошибке в протокол
    --
     procedure error(
         p_msg    in   varchar2)
     is

     l_recid   number(38);

     begin

         write_message(
             p_rectype  => 'ERROR',
             p_module   => null,
             p_machine  => null,
             p_msg      => p_msg,
             p_recid    => l_recid  );

     end error;


    -------------------------------------------------------
    -- FATAL()
    --
    --   Запись сообщения о критической ошибке в протокол
    --
     procedure fatal(
         p_msg    in   varchar2)
     is

     l_recid   number(38);

     begin

         write_message(
             p_rectype  => 'FATAL',
             p_module   => null,
             p_machine  => null,
             p_msg      => p_msg,
             p_recid    => l_recid  );

     end fatal;













    -------------------------------------------------------
    -- TRACE()
    --
    --   Запись трассировочного сообщения в протокол
    --
     procedure trace(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number,
         p_arg1    in   varchar2  default null,
         p_arg2    in   varchar2  default null,
         p_arg3    in   varchar2  default null,
         p_arg4    in   varchar2  default null,
         p_arg5    in   varchar2  default null,
         p_arg6    in   varchar2  default null,
         p_arg7    in   varchar2  default null,
         p_arg8    in   varchar2  default null,
         p_arg9    in   varchar2  default null )
     is

     l_msg     sec_audit.rec_message%type;
     l_object  varchar2(100);

     begin

         if (g_logLevel < LOG_LEVEL_TRACE) then
             return;
         end if;

          l_object := get_object();

          if (g_trcObject = 'ALL'
              or instr(',' || g_trcObject || ',', ',' || l_object || ',') !=0) then
                 null;
          else
              return;
          end if;

         -- обрабатываем параметры
         l_msg := printf(p_msg,args(substr(p_arg1, 1, 2000),
                                    substr(p_arg2, 1, 2000),
                                    substr(p_arg3, 1, 2000),
                                    substr(p_arg4, 1, 2000),
                                    substr(p_arg5, 1, 2000),
                                    substr(p_arg6, 1, 2000),
                                    substr(p_arg7, 1, 2000),
                                    substr(p_arg8, 1, 2000),
                                    substr(p_arg9, 1, 2000) ));

         write_message(
             p_rectype  => 'TRACE',
             p_module   => null,
             p_object   => l_object,
             p_machine  => null,
             p_msg      => l_msg,
             p_recid    => p_recid  );

     end trace;



     procedure trace(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number,
         p_args    in   args     default emptyArgs)
     is

     l_object  varchar2(100);

     begin

         if (g_logLevel < LOG_LEVEL_TRACE) then
             return;
         end if;

          l_object := get_object();

          if (g_trcObject = 'ALL'
              or instr(',' || g_trcObject || ',', ',' || l_object || ',') !=0) then
                 null;
          else
              return;
          end if;

         write_message(
             p_rectype  => 'TRACE',
             p_module   => null,
             p_object   => l_object,
             p_machine  => null,
             p_msg      => printf(p_msg, p_args),
             p_recid    => p_recid  );

     end trace;


    -------------------------------------------------------
    -- DEBUG()
    --
    --   Запись отладочного сообщения в протокол
    --
     procedure debug(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 )
     is
     begin

         write_message(
             p_rectype  => 'DEBUG',
             p_module   => p_module,
             p_machine  => p_machine,
             p_msg      => p_msg,
             p_recid    => p_recid   );

     end debug;


    -------------------------------------------------------
    -- INFO()
    --
    --   Запись информационного сообщения в протокол
    --
     procedure info(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 )
     is
     begin

         write_message(
             p_rectype  => 'INFO',
             p_module   => p_module,
             p_machine  => p_machine,
             p_msg      => p_msg,
             p_recid    => p_recid   );

     end info;


    -------------------------------------------------------
    -- SECURITY()
    --
    --   Запись в протокол сообщения безопасности
    --
     procedure security(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 )
     is
     begin

         write_message(
             p_rectype  => 'SECURITY',
             p_module   => p_module,
             p_machine  => p_machine,
             p_msg      => p_msg,
             p_recid    => p_recid   );

     end security;

    -------------------------------------------------------
    -- FINANCIAL()
    --
    --   Запись финансового сообщения в протокол
    --
     procedure financial(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 )
     is
     begin

         write_message(
             p_rectype  => 'FINANCIAL',
             p_module   => p_module,
             p_machine  => p_machine,
             p_msg      => p_msg,
             p_recid    => p_recid   );

     end financial;



    -------------------------------------------------------
    -- WARNING()
    --
    --   Запись предупреждения в протокол
    --
     procedure warning(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 )
     is
     begin

         write_message(
             p_rectype  => 'WARNING',
             p_module   => p_module,
             p_machine  => p_machine,
             p_msg      => p_msg,
             p_recid    => p_recid   );

     end warning;



    -------------------------------------------------------
    -- ERROR()
    --
    --   Запись сообщение об ошибке в протокол
    --
     procedure error(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 )
     is
     begin

         write_message(
             p_rectype  => 'ERROR',
             p_module   => p_module,
             p_machine  => p_machine,
             p_msg      => p_msg,
             p_recid    => p_recid   );

     end error;




    -------------------------------------------------------
    -- FATAL()
    --
    --   Запись сообщения о критической ошибке в протокол
    --
     procedure fatal(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 )
     is
     begin

         write_message(
             p_rectype  => 'FATAL',
             p_module   => p_module,
             p_machine  => p_machine,
             p_msg      => p_msg,
             p_recid    => p_recid   );

     end fatal;









    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    Запись в журнал аудита сообщения заданного типа
    --
    --
     procedure write_message(
         p_eventType   in  sec_audit.rec_type%type,
         p_bankDate    in  sec_audit.rec_bdate%type,
         p_message     in  sec_audit.rec_message%type )
     is

     l_recid    number(38);

     begin

         write_message(
             p_rectype  => p_eventType,
             p_module   => null,
             p_machine  => null,
             p_msg      => p_message,
             p_recid    => l_recid   );

     end write_message;


    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    Запись в журнал аудита сообщения заданного типа
    --    с указанием имени машины клиента
    --
    --
     procedure write_message(
         p_eventType   in  sec_audit.rec_type%type,
         p_bankDate    in  sec_audit.rec_bdate%type,
         p_message     in  sec_audit.rec_message%type,
         p_machine     in  sec_audit.machine%type)
     is

     l_recid    number(38);

     begin

         write_message(
             p_rectype  => p_eventType,
             p_module   => null,
             p_machine  => p_machine,
             p_msg      => p_message,
             p_recid    => l_recid   );

     end write_message;

    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    Запись в журнал аудита сообщения заданного типа
    --
    --
     procedure write_message(
         p_eventType   in  positive,
         p_bankDate    in  sec_audit.rec_bdate%type,
         p_message     in  sec_audit.rec_message%type )
     is

     l_recid    number(38);

     begin

         write_message(
             p_rectype  => get_level_name(p_eventType),
             p_module   => null,
             p_machine  => null,
             p_msg      => p_message,
             p_recid    => l_recid   );

     end write_message;

    -------------------------------------------------------
    -- WRITE_MESSAGE_AUX()
    --
    --    Запись в журнал аудита сообщения заданного типа
    --
    --
     procedure write_message_aux(
         p_eventType   in  sec_audit.rec_type%type,
         p_bankDate    in  sec_audit.rec_bdate%type,
         p_message     in  sec_audit.rec_message%type )
     is

     l_recid    number(38);

     begin

         write_message(
             p_rectype  => p_eventType,
             p_module   => null,
             p_machine  => null,
             p_msg      => p_message,
             p_recid    => l_recid   );

     end write_message_aux;

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
        return 'package header BARS_AUDIT ' || g_headerVersion || chr(10) ||
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
        return 'package body BARS_AUDIT ' || g_bodyVersion || chr(10) ||
               'package body definition(s):' || chr(10) || g_bodyDefs;
    end body_version;

  --------------------------------------------------------
  -- TRACE_ENABLED()
  --
  --     Функция возвращает true/false -
  --     признак включения трассировки
  --
  --
  function trace_enabled return boolean is
  begin
    if g_logLevel=LOG_LEVEL_TRACE then
        return true;
    else
        return false;
    end if;
  end trace_enabled;

  --------------------------------------------------------
  -- CLEAR_SESSION_CONTEXT
  --
  --     Очистка сессионного контекста
  --
  --
  procedure clear_session_context
  is
  begin
      sys.dbms_session.clear_context('bars_audit', client_id=> sys_context('userenv', 'client_identifier'));
  end clear_session_context;

  --------------------------------------------------------
  -- DISCARD_TRACING
  --
  --     Сбрасываем трассировку сессий по истечению времени
  --     в параметре TRACEDAY
  --
  --
  procedure discard_tracing
  is
    type t_ids is table of integer index by pls_integer;
    l_traceday 	number;
    l_ids 		t_ids;
  begin
    begin
        select to_number(val)
          into l_traceday
          from params
         where par = 'TRACEDAY';
    exception
        when no_data_found then
            l_traceday := 2;
    end;
    --
      update sec_useraudit
       set log_level = 'INFO',
           update_time = sysdate,
           update_comment = 'Скінчився термін аудиту '||l_traceday||' дні(в) з рівнем TRACE'
     where log_level = 'TRACE'
       and update_time < sysdate - l_traceday
     returning staff_id bulk collect into l_ids;
    --
    for i in 1..l_ids.count
    loop
        logger.warning('Скінчився термін аудиту '||l_traceday||' дні(в) з рівнем TRACE для сесій користувача id='||l_ids(i));
    end loop;
    --
  end discard_tracing;

    function get_context_snapshot
    return varchar2
    is
        l_values string_list;
    begin
        select rpad(upper(key), max(length(key)) over()) || ' : ' || value
        bulk collect into l_values
        from   (select ' ora_login_user' key, ora_login_user value from dual
                union all
                select ' userenv - sid', sys_context('userenv', 'sid') from dual
                union all
                select ' userenv - sessionid', sys_context('userenv', 'sessionid') from dual
                union all
                select ' userenv - client_identifier', sys_context('userenv', 'client_identifier') from dual
                union all
                select ' userenv - host', sys_context('userenv', 'host') from dual
                union all
                select ' userenv - module', sys_context('userenv', 'module') from dual
                --union all
                --select t.namespace || ' - ' || t.attribute, t.value
                --from   gv$globalcontext t
                --where  t.client_identifier = sys_context('userenv', 'client_identifier')
                order by 1);

        return tools.words_to_string(l_values, p_splitting_symbol => chr(10), p_ceiling_length => 4000, p_ignore_nulls => 'Y');
    end;

    procedure log_message(
        p_log_level in integer,
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean)
    is
        pragma autonomous_transaction;
        l_log_level_name varchar2(10 char);
        l_context_snapshot varchar2(4000 byte);
    begin
        if (g_logLevel < p_log_level) then
            return;
        end if;

        -- для событий протоколирования ошибок и событий подсистемы безопасности
        -- делаем снимок контекстных переменных автоматически (в независимости от значения параметра p_make_context_snapshot)
        l_context_snapshot := case when p_make_context_snapshot or
                                        p_log_level in (bars_audit.LOG_LEVEL_SECURITY, bars_audit.LOG_LEVEL_ERROR, bars_audit.LOG_LEVEL_FATAL) then
					substrb(get_context_snapshot(), 1, 4000)
                                   else null
                              end;

        l_log_level_name := get_level_name(p_log_level);

        insert into log_table
        values (s_log_table.nextval,
                l_log_level_name,
                substrb(p_procedure_name, 1, 4000),
                substrb(p_object_id, 1, 4000),
                substrb(p_log_message, 1, 4000),
                p_auxiliary_info,
                l_context_snapshot,
                sys_context('bars_global', 'user_id'),
                sysdate);

        commit;
    end;

    procedure log_trace(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false)
    is
    begin
        log_message(bars_audit.LOG_LEVEL_TRACE, p_procedure_name, p_log_message, p_object_id, p_auxiliary_info, p_make_context_snapshot);
    end;

    procedure log_debug(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false)
    is
    begin
        log_message(bars_audit.LOG_LEVEL_DEBUG, p_procedure_name, p_log_message, p_object_id, p_auxiliary_info, p_make_context_snapshot);
    end;

    procedure log_info(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false)
    is
    begin
        log_message(bars_audit.LOG_LEVEL_INFO, p_procedure_name, p_log_message, p_object_id, p_auxiliary_info, p_make_context_snapshot);
    end;

    procedure log_security(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false)
    is
    begin
        log_message(bars_audit.LOG_LEVEL_SECURITY, p_procedure_name, p_log_message, p_object_id, p_auxiliary_info, p_make_context_snapshot);
    end;

    procedure log_financial(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false)
    is
    begin
        log_message(bars_audit.LOG_LEVEL_FINANCIAL, p_procedure_name, p_log_message, p_object_id, p_auxiliary_info, p_make_context_snapshot);
    end;

    procedure log_warning(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false)
    is
    begin
        log_message(bars_audit.LOG_LEVEL_WARNING, p_procedure_name, p_log_message, p_object_id, p_auxiliary_info, p_make_context_snapshot);
    end;

    procedure log_error(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false)
    is
    begin
        log_message(bars_audit.LOG_LEVEL_ERROR, p_procedure_name, p_log_message, p_object_id, p_auxiliary_info, p_make_context_snapshot);
    end;

    procedure log_fatal(
        p_procedure_name in varchar2,
        p_log_message in varchar2,
        p_object_id in varchar2 default null,
        p_auxiliary_info in clob default null,
        p_make_context_snapshot in boolean default false)
    is
    begin
        log_message(bars_audit.LOG_LEVEL_FATAL, p_procedure_name, p_log_message, p_object_id, p_auxiliary_info, p_make_context_snapshot);
    end;
begin
    load_param();
end bars_audit;
/
 show err;
 
PROMPT *** Create  grants  BARS_AUDIT ***
grant EXECUTE                                                                on BARS_AUDIT      to ABS_ADMIN;
grant EXECUTE                                                                on BARS_AUDIT      to AUDIT_ROLE;
grant EXECUTE                                                                on BARS_AUDIT      to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_AUDIT      to BARSAQ_ADM;
grant EXECUTE                                                                on BARS_AUDIT      to BARSUPL;
grant EXECUTE                                                                on BARS_AUDIT      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_AUDIT      to BARS_CONNECT;
grant EXECUTE                                                                on BARS_AUDIT      to BARS_DM;
grant EXECUTE                                                                on BARS_AUDIT      to DM;
grant EXECUTE                                                                on BARS_AUDIT      to DPT;
grant EXECUTE                                                                on BARS_AUDIT      to DPT_ROLE;
grant EXECUTE                                                                on BARS_AUDIT      to FINMON01;
grant EXECUTE                                                                on BARS_AUDIT      to IBS;
grant EXECUTE                                                                on BARS_AUDIT      to LOG_ROLE;
grant EXECUTE                                                                on BARS_AUDIT      to START1;
grant EXECUTE                                                                on BARS_AUDIT      to UPLD;
grant EXECUTE                                                                on BARS_AUDIT      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on BARS_AUDIT      to BARS_INTGR;
