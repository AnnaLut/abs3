prompt package/bars_audit.sql
  CREATE OR REPLACE PACKAGE BARS.BARS_AUDIT 
is

    -------------------------------------------------------
    --
    --  ����� ��� ���������������� ������ ���������
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
    -- ��������� ����
    --
    --
     type args is table of varchar2(2000);
     emptyArgs args;


    -------------------------------------------------------
    --
    -- ���������
    --
    --   ���� ��������� ���������
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
    -- ����� ������ ���������
    --
     OUTPUT_ON            constant number := 1;
     OUTPUT_OFF           constant number := 0;




    -------------------------------------------------------
    -- GET_MODULE()
    --
    --   ��������� ����� �������� ����� ������
    --
     function get_module return varchar2;


    -------------------------------------------------------
    -- SET_MODULE()
    --
    --   ��������� ����� �������� ������
    --
     procedure set_module(
         p_module  in   varchar2);


    -------------------------------------------------------
    -- GET_MACHINE()
    --
    --   ������� ��������� �������������� ��� ������� ������
    --   ����� ������  (��� ������������� ����� ������)
    --
     function get_machine return varchar2;


    -------------------------------------------------------
    -- SET_MACHINE()
    --
    --   ��������� ��������� ����� ������ ��� �������
    --   ������ (��� ������������� ����� ������)
    --
    --
     procedure set_machine(
         p_machine  in   varchar2);

    -------------------------------------------------------
    -- GET_LOG_LEVEL()
    --
    --   �������� ������������� �������
    --   ����������� ���������
    --
     function get_log_level return number;

    -------------------------------------------------------
    -- SET_LOG_LEVEL()
    --
    --   ��������� ��������� ������ ���������������� ���
    --   ������� ������
    --
     procedure set_log_level(
         p_loglevel in  number );


    -------------------------------------------------------
    -- GET_OUTPUT()
    --
    --   �������� ������������� ����� ������ ���������
    --   � ������� dbms_output
    --
     function get_output return number;

    -------------------------------------------------------
    -- SET_OUTPUT()
    --
    --   ���������� ����� ������ ���������
    --   � ������� dbms_output
    --
     procedure set_output(
         p_mode in  number );


    -------------------------------------------------------
    -- GET_TRACE_OBJECTS()
    --
    --   �������� ������ �������� ��� �����������
    --
     function get_trace_objects return varchar2;

    -------------------------------------------------------
    -- SET_TRACE_OBJECTS()
    --
    --   ���������� ������ �������� ��� �����������
    --
     procedure set_trace_objects(
         p_traceobjs in  varchar2 );

    -------------------------------------------------------
    --
    --   ������ �������� ��� ���������������� ������
    --   ��� ������ � ������������� ����������� ���
    --   ����������� ��������� �������������� ������
    --
    --   ������� ���������:
    --
    --      p_msg       ����� ���������
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
    -- ������ �������� ��� ������ � ������ ������������
    -- � ������������ �������� ����� ������ ��� 3-�
    -- ��������� ������� � ��������� ��������������
    -- ������ ������� ������������
    --
    --   ������� ���������:
    --
    --      p_msg       ����� ���������
    --
    --      p_module    ��� ������, � ������� ����������
    --                  ����� ����������������
    --
    --      p_machine   ��� ���������� ������
    --                  ��� ������ � ������������� ����-
    --                  ������� ���������� ����������
    --                  ��� ������, �.�. ��� ����� ������
    --                  � �� �������� ������ ����������
    --
    --   �������� ���������:
    --
    --      p_recid     ������������� ������ �������
    --                  ������������
    --


    -------------------------------------------------------
    -- TRACE()
    --
    --   ������ ��������������� ��������� � ��������
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
    --   ������ ����������� ��������� � ��������
    --
     procedure debug(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );


    -------------------------------------------------------
    -- INFO()
    --
    --   ������ ��������������� ��������� � ��������
    --
     procedure info(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );


    -------------------------------------------------------
    -- SECURITY()
    --
    --   ������ � �������� ��������� ������������
    --
     procedure security(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );

    -------------------------------------------------------
    -- FINANCIAL()
    --
    --   ������ ����������� ��������� � ��������
    --
     procedure financial(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );



    -------------------------------------------------------
    -- WARNING()
    --
    --   ������ �������������� � ��������
    --
     procedure warning(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );



    -------------------------------------------------------
    -- ERROR()
    --
    --   ������ ��������� �� ������ � ��������
    --
     procedure error(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );




    -------------------------------------------------------
    -- FATAL()
    --
    --   ������ ��������� � ����������� ������ � ��������
    --
     procedure fatal(
         p_msg     in   varchar2,
         p_module  in   varchar2 default null,
         p_machine in   varchar2 default null,
         p_recid   out  number                 );







    -------------------------------------------------------
    --                                                   --
    --  ����� ��������� ��� ������ ���������             --
    --                                                   --
    -------------------------------------------------------


    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    ������ � ������ ������ ��������� ��������� ����
    --
    --
     procedure write_message(
         p_eventType   in  sec_audit.rec_type%type,
         p_bankDate    in  sec_audit.rec_bdate%type,
         p_message     in  sec_audit.rec_message%type );


    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    ������ � ������ ������ ��������� ��������� ����
    --    � ��������� ����� ������ �������
    --
    --    ������������ � 3-� ������� �����������, ���
    --    ���������� ������ �� ����� ���� ����������
    --    �������� ��
    --
     procedure write_message(
         p_eventType   in  sec_audit.rec_type%type,
         p_bankDate    in  sec_audit.rec_bdate%type,
         p_message     in  sec_audit.rec_message%type,
         p_machine     in  sec_audit.machine%type     );


    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    ������ � ������ ������ ��������� ��������� ����
    --
    --
     procedure write_message(
         p_eventType   in  positive,
         p_bankDate    in  sec_audit.rec_bdate%type,
         p_message     in  sec_audit.rec_message%type );

    -------------------------------------------------------
    -- WRITE_MESSAGE()
    --
    --    ������ � ������ ������ ��������� ��������� ����
    --    ����� ���������� ��� Centura
    --
       procedure write_message_aux(
           p_eventType   in  sec_audit.rec_type%type,
           p_bankDate    in  sec_audit.rec_bdate%type,
           p_message     in  sec_audit.rec_message%type );



    --------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ���������� ������ � ������� ��������� ������
    --
    --
    --
    function header_version return varchar2;

    --------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ���������� ������ � ������� ���� ������
    --
    --
    --
    function body_version return varchar2;


    -------------------------------------------------------
    --
    -- ���������� ��������� ������ ����������������
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
    --     ������� ���������� true/false -
    --     ������� ��������� �����������
    --
    --
    function trace_enabled return boolean;

    --------------------------------------------------------
    -- CLEAR_SESSION_CONTEXT
    --
    --     ������� ����������� ���������
    --
    --
    procedure clear_session_context;

    --------------------------------------------------------
    -- DISCARD_TRACING
    --
    --     ���������� ����������� ������ �� ��������� �������
    --     � ��������� TRACEDAY
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


     g_bodyVersion   constant varchar2(64)  := 'version 1.24 16.10.2012';
     g_bodyDefs      constant varchar2(512) := ''
              || '          ��� ���� ������'       || chr(10)

;

    -------------------------------------------------------
    -- ���������� ��������� ������
    --
    --
     MAX_MODULE_LEN       constant positive := 30;
     MAX_OBJECT_LEN       constant positive := 100;
     MAX_RECTYPE_LEN      constant positive := 10;
     MAX_MESSAGE_LEN      constant positive := 4000;
     MAX_MACHINE_LEN      constant positive := 255;

     MODULE_PREFIX        constant varchar2(3) := 'SEC';


    -------------------------------------------------------
    -- ���������� ���������� ������
    --
    --
    --
    g_alarmlist    varchar2(2000);  /*  ������ ����� ��������� ��� ����������� */
    g_alarmLoaded  boolean;         /* ������� �������� ������ ����� ��������� */
    g_moduleName   varchar2(30);    /*       ������������� ��� �������� ������ */
    g_machineName  varchar2(255);   /*     ������������� ��� ���������� ������ */
    g_trcObject    varchar2(2000);  /*         ������ �������� ��� ����������� */
    g_absUserID    number;          /*  ������������� ������������ � ��������� */
    g_userBranch   varchar2(30);    /*          ��� ������������� ������������ */
    g_logLevel     number;          /*             ������� ������� ����������� */
    g_isPkgDebug   boolean;         /*              ������� ���������� ������� */
    g_isSaveStack  boolean;         /*         ������� ���������� ����� ������ */
    g_output       number;          /*    ������� ������ ��������� dbms_output */





    -------------------------------------------------------
    -- GET_LEVEL_ID()
    --
    --   ��������� ��������� �� ����������� ��������
    --   ���� ���������
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
    --   ��������� ����������� �������� ���� ���������
    --   �� ��� �������� ���������
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
    --    ��������� ��������� ������ ����� ��������� ���
    --    ������������� ������� ���������� ������� �� �
    --    ������� �����������
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

         -- ��������� �������� � ���������
         if (g_alarmloaded) then
             sys.dbms_session.set_context('bars_audit', 'alarm_list', g_alarmlist, client_id=>sys_context('userenv', 'client_identifier'));
         else
             sys.dbms_session.set_context('bars_audit', 'alarm_list', '<NULL>',    client_id=>sys_context('userenv', 'client_identifier'));
         end if;

     end load_alarm;




    -------------------------------------------------------
    -- LOAD_LOG_LEVEL()
    --
    --   ��������� ����������������� ������
    --   ����������� ���������
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

        -- ���� ������ ��� ���� � ���������, �� ������ ������
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

         -- ��������� ��������� � ���������
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
    --   ��������� ������������� ���������
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

         -- �������� ����� �� �������, ���� ������ ���������� g_output
         if g_output = OUTPUT_ON
         then
            dbms_output.enable(null);
         end if;
         --
     end load_param;



    -------------------------------------------------------
    -- WRITE_ALARM()
    --
    --    ��������� ������� ���������� �� ������
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
    --    ��������� ������ ������ � ������ ������������
    --
    --    ! �������� ��������� ������ � �������� !
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

         l_appModule   varchar2(48);        /* ��� ������ �����. ����� dbms_application_info */
         l_appAction   varchar2(32);        /*   �������� �����. ����� dbms_application_info */

         guard_error   exception;
         pragma exception_init(guard_error, -16224);

     begin

         --
         -- ��������� ����������� ����������������
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
         -- ��� ������ ���� ����������, ���� �������
         -- ������������� � ������� SET_MODULE ���
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
         -- ���������� ���������� ����
         -- ���������� ���� ������������ ������������
         -- � ��������� BARS_GL. ���� �������� �� ������
         -- ������ �� ���������� (�� ���� ������ ������ GL),
         -- �� ����� ���������� ���������� ���� �� BARS_CONTEXT
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

         -- ��� ������ ��������������� � ���������
         l_machine := substr(nvl(g_machinename, sys_context('bars_global', 'host_name'))||'('||sys_context('USERENV', 'IP_ADDRESS')||')', 1, MAX_MACHINE_LEN);

         -- �������� ��� ������� ��� ������
         if(l_machine is null and sys_context('userenv', 'bg_job_id') is not null) then
             l_machine := 'LOCALHOST';
         end if;

         -- ��� ��� ������ bug � ������ 9.2.0.4
         if (l_machine is null) then
             l_machine := 'NOT AVAILABLE';
         end if;

         -- ��������� ������ � ������ ������
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
         -- ���� ������� ����� �����������,
         -- �� ���������� ��������� �����������
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
         -- ���� ������� ����� � dbms_output, �� ��������� ���������
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
    --   ��������� ����� �������� ����� ������
    --
     function get_module return varchar2
     is
     begin
         return g_moduleName;
     end get_module;


    -------------------------------------------------------
    -- SET_MODULE()
    --
    --   ��������� ����� �������� ������
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
    --   ������� ��������� �������������� ��� ������� ������
    --   ����� ������  (��� ������������� ����� ������)
    --
     function get_machine return varchar2
     is
     begin
         return g_machineName;
     end get_machine;


    -------------------------------------------------------
    -- SET_MACHINE()
    --
    --   ��������� ��������� ����� ������ ��� �������
    --   ������ (��� ������������� ����� ������)
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
    --   �������� ������������� �������
    --   ����������� ���������
    --
     function get_log_level return number
     is
     begin

         return g_logLevel;

     end get_log_level;

    -------------------------------------------------------
    -- SET_LOG_LEVEL()
    --
    --   ��������� ��������� ������ ���������������� ���
    --   ������� ������
    --
     procedure set_log_level(
         p_loglevel in  number )
     is

     l_levelname  sec_audit.rec_type%type;  /* ��� ���� ��������� */

     begin

         -- ��� �������� ������������ ������
         l_levelname := get_level_name(p_loglevel);
         -- ����� � ����������
         g_logLevel := p_loglevel;
         -- � ����� � ��������
         sys.dbms_session.set_context('bars_audit', 'log_level',     to_char(g_logLevel), client_id=>sys_context('userenv', 'client_identifier'));

     end set_log_level;

    -------------------------------------------------------
    -- GET_OUTPUT()
    --
    --   �������� ������������� ����� ������ ���������
    --   � ������� dbms_output
    --
     function get_output return number
     is
     begin
         return g_output;
     end get_output;

    -------------------------------------------------------
    -- SET_OUTPUT()
    --
    --   ���������� ����� ������ ���������
    --   � ������� dbms_output
    --
     procedure set_output(
         p_mode in  number )
     is
     begin

         if (p_mode not in (OUTPUT_ON, OUTPUT_OFF)) then
               g_output := OUTPUT_OFF;
         end if;

         g_output := p_mode;

         -- ����� � ��������
         sys.dbms_session.set_context('bars_audit', 'dbms_output', to_char(g_output), client_id=>sys_context('userenv', 'client_identifier'));

         -- �������� ����� �� �������, ���� ������ ���������� g_output
         if g_output = OUTPUT_ON
         then
            dbms_output.enable(null);
         end if;
         --

     end set_output;


  -------------------------------------------------------
  -- GET_TRACE_OBJECTS()
  --
  --   �������� ������ �������� ��� �����������
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
  --   ���������� ������ �������� ��� �����������
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
   --     �� ��������� �����, ��������� ���������� �����, ��� �������
   --     � ����� ������, ������ ��� ���������� ����� ������ ������-
   --     �����
   --
    function get_object return varchar2
    is

    --
    -- ������� �����������, ������� �� ���������� ����������
    -- ������� � ������. ������� ���������� �������:
    --
    --   USER MODULE -> BARS_AUDIT.TRACE         ->
    --                  BARS_AUDIT.GET_OBJECT
    --
    -- ����� ������� ������, ������� �������� ����� �����������
    -- ����� �������
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

        -- �������
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.GET_OBJECT: proc entry point');
        end if;

        --
        -- � ���������� L_STACK �� �������� ������� ����.
        -- ���� ������������ ����� ������ �� 2� ����. ����:
        --
        --        ----- PL/SQL Call Stack -----
        --    object      line  object
        --    handle    number  name
        --  6D637684         1  anonymous block
        --
        -- ����� ������� ���� ������� �� ��������� � ����������
        -- ����� �������. ������� �� ������� ������ ����������
        -- ��������� ������ ���������, ����� ���������� ���-��
        -- �����, ��������� � ��������� CL_FIRST_CALLER, � ���-
        -- ������ ������ ����� ��������� ���������� � ����������
        -- ��� �������
        --

        -- �������
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.GET_OBJECT: begin stack parsing');
        end if;


        loop

            --
            -- �������� ������ �� ������� �������� ������. ����
            -- ������� �������� ������ ���, �� �������. �������
            -- � � ��� ������, ���� ������� �������� ����� ���
            -- ������, ��� ��������� ������� �����������
            --
            l_linesep := instr(l_stack, chr(10));
            exit when (l_callerLevel = CL_FIRST_CALLER+1 or l_linesep is null or l_linesep = 0);

            -- �������� ������, ��������� ����� ��������� �����
            l_line  := substr(l_stack, 1, l_linesep-1);
            l_stack := substr(l_stack, l_linesep+1);

            if (not l_stackFound) then

                if (l_line like '%handle%number%name%') then

                    -- �������
                    if (g_isPkgDebug) then
                        dbms_output.put_line('BARS_AUDIT.GET_OBJECT: stack hdr end line found');
                    end if;

                    l_stackFound := true;
                end if;

            else

                l_callerLevel := l_callerLevel + 1;

                if (l_callerLevel = CL_FIRST_CALLER) then

                    -- �������
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

                    -- �������
                    if (g_isPkgDebug) then
                        dbms_output.put_line('BARS_AUDIT.GET_OBJECT: stack line parsed');
                    end if;

                end if;

            end if;

        end loop;

        -- �������
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
   --     ��������� �������������� ������ ���������. ���� � ������
   --     �������� ��������, �� ������������ ����������� ����������
   --     ���������� � ������ ���������
   --
   --
    function printf(
        p_message  in varchar2,
        p_args     in args     ) return varchar2
    is

    l_src     varchar2(4000);
    l_message varchar2(4000);
    l_argc    number;                      -- ���������� ��������� �������
    l_argn    number           default 1;  -- ������� ������� �������
    l_pos     number           default 0;

    begin

        -- �������
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: proc entry point'                                 );
            dbms_output.put_line('BARS_AUDIT.PRINTF: proc arg[0]="' || substr(p_message, 1, 200) || '"');
            for i in p_args.first..p_args.last
            loop
                dbms_output.put_line('BARS_AUDIT.PRINTF: proc arg[2,' || to_char(i) || ']="' || p_args(i) || '"');
            end loop;
        end if;

        --
        -- ���� � ������ ��������� (p_message) ������ % ��� \, ���
        -- ��������� ��������� �� ����� ����������� ��������� ���
        -- ������� �������� ������. ���� � ������ ��� �� ������ ��
        -- ����� ��������, �� ������ � ������� ��������� ������ ��
        -- ����� - ������ ������� �������� ������ ���������
        --

        if (instr(p_message, '%') = 0 and instr(p_message, '\') = 0 ) then

            -- �������
            if (g_isPkgDebug) then
                dbms_output.put_line('BARS_AUDIT.PRINTF: specifications not found. Return original message');
                dbms_output.put_line('BARS_AUDIT.PRINTF: return message="' || substr(p_message, 1, 200) || '"');
            end if;

           return p_message;
        end if;

        -- �������
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: begin parsing');
        end if;

        --
        -- �������� ���-�� ���������� � ������ ��� �������
        --
        l_argc := p_args.count;
        l_src  := p_message;

        --
        -- ���� � ������������ ��������� �� ����������� ����������
        --

        -- �������
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: replacing %s specification');
        end if;

        loop

            --
            -- �������� ������ ������� ������� %s
            --
            l_pos := instr(l_src, '%s');

            -- �������
            if (g_isPkgDebug) then
                dbms_output.put_line('BARS_AUDIT.PRINTF: arg spec at pos ' || to_char(l_pos));
            end if;

            --
            -- �������, ���� ������� ��� (0, null) ��� ���
            -- ���������� ��� ��������� ���������
            --
            exit when (l_pos = 0 or l_pos is null or l_argn > l_argc);

            --
            -- ��������� ����� �� ��������� � ������� ��������
            -- � �������� ���������
            --
            l_message := substr(l_message || substr(l_src, 1, l_pos-1) || p_args(l_argn), 1, 4000);
            l_src     := substr(l_src, l_pos+2);
            l_argn    := l_argn + 1;


            -- �������
            if (g_isPkgDebug) then
                dbms_output.put_line('BARS_AUDIT.PRINTF: msg="' || l_message || '"');
            end if;

        end loop;

        -- �������
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: replacing %s specification complete');
        end if;

        --
        -- ��������� ���������� ����� ��������� � ��������
        -- � �������� ����� �������� �������� ������
        --
        l_src     := substr(l_message || l_src, 1, 4000);
        l_message := null;

        --
        -- ���� � ������������ ��������� �������� ������
        --

        -- �������
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: searching \n specification');
        end if;


        loop
            --
            -- �������� ������ ������� �������� \n
            --
            l_pos := instr(l_src, '\n');

            -- �������
            if (g_isPkgDebug) then
                dbms_output.put_line('BARS_AUDIT.PRINTF: endline spec at pos ' || to_char(l_pos));
            end if;

            --
            -- �������, ���� �������� ��� (0, null)
            --
            exit when (l_pos = 0 or l_pos is null);

            l_message := substr(l_message || substr(l_src, 1, l_pos-1) || chr(10), 1, 4000);
            l_src := substr(l_src, l_pos+2);

        end loop;

        -- �������
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: replacing \n specification complete');
        end if;

        --
        -- ��������� ���������� ����� ��������� ���������
        --
        l_message := substr(l_message || l_src, 1, 4000);

        -- �������
        if (g_isPkgDebug) then
            dbms_output.put_line('BARS_AUDIT.PRINTF: end parsing');
            dbms_output.put_line('BARS_AUDIT.PRINTF: ret msg="' || l_message || '"');
        end if;

        return l_message;

    end printf;




































    -------------------------------------------------------
    -- TRACE()
    --
    --   ������ ��������������� ��������� � ��������
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

          -- ������������ ���������
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
    --    ������ ��������������� ��������� � ��������
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
    --   ������ ����������� ��������� � ��������
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
    --   ������ ��������������� ��������� � ��������
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
    --   ������ � �������� ��������� ������������
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
    --   ������ ����������� ��������� � ��������
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
    --   ������ �������������� � ��������
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
    --   ������ ��������� �� ������ � ��������
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
    --   ������ ��������� � ����������� ������ � ��������
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
    --   ������ ��������������� ��������� � ��������
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

         -- ������������ ���������
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
    --   ������ ����������� ��������� � ��������
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
    --   ������ ��������������� ��������� � ��������
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
    --   ������ � �������� ��������� ������������
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
    --   ������ ����������� ��������� � ��������
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
    --   ������ �������������� � ��������
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
    --   ������ ��������� �� ������ � ��������
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
    --   ������ ��������� � ����������� ������ � ��������
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
    --    ������ � ������ ������ ��������� ��������� ����
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
    --    ������ � ������ ������ ��������� ��������� ����
    --    � ��������� ����� ������ �������
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
    --    ������ � ������ ������ ��������� ��������� ����
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
    --    ������ � ������ ������ ��������� ��������� ����
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
    --     ������� ���������� ������ � ������� ��������� ������
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
    --     ������� ���������� ������ � ������� ���� ������
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
  --     ������� ���������� true/false -
  --     ������� ��������� �����������
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
  --     ������� ����������� ���������
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
  --     ���������� ����������� ������ �� ��������� �������
  --     � ��������� TRACEDAY
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
           update_comment = '�������� ����� ������ '||l_traceday||' ��(�) � ����� TRACE'
     where log_level = 'TRACE'
       and update_time < sysdate - l_traceday
     returning staff_id bulk collect into l_ids;
    --
    for i in 1..l_ids.count
    loop
        logger.warning('�������� ����� ������ '||l_traceday||' ��(�) � ����� TRACE ��� ���� ����������� id='||l_ids(i));
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
                union all
                select t.namespace || ' - ' || t.attribute, t.value
                from   gv$globalcontext t
                where  t.client_identifier = sys_context('userenv', 'client_identifier')
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

        -- ��� ������� ���������������� ������ � ������� ���������� ������������
        -- ������ ������ ����������� ���������� ������������� (� ������������� �� �������� ��������� p_make_context_snapshot)
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
