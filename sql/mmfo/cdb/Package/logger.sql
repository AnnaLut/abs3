
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/logger.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.LOGGER is

    -- Author  : Artem Yurchenko
    -- Created : 23.11.2012

    LOG_LEVEL_INFO                 constant integer := 1;
    LOG_LEVEL_WARNING              constant integer := 2;
    LOG_LEVEL_ERROR                constant integer := 3;
    LOG_LEVEL_DEBUG                constant integer := 4;
    LOG_LEVEL_TRACE                constant integer := 5;

    function is_logging_on return boolean;

    function is_total_logging_on return boolean;

    function get_log_level return integer;

    procedure set_log_level(p_log_level in integer);

    function is_tracking_on_for_procedure(p_procedure_name in varchar2) return boolean;

    procedure set_tracking_on_for_procedure(p_procedure_name in varchar2);

    procedure set_tracking_off_for_procedure(p_procedure_name in varchar2);

    procedure log(
        p_procedure_name in varchar2,
        p_log_level      in integer,
        p_log_message    in clob);

    procedure log(
        p_procedure_name in varchar2,
        p_log_message    in clob);

end logger;
/
CREATE OR REPLACE PACKAGE BODY CDB.LOGGER is

    g_log_level integer;

    function is_logging_on
    return boolean
    is
    begin
        return true;
    end;

    function is_total_logging_on
    return boolean
    is
    begin
        return true;
    end;

    function get_log_level
    return integer
    is
    begin
        return g_log_level;
    end;

    procedure set_log_level(p_log_level in integer)
    is
    begin
        g_log_level := p_log_level;
    end;

    function is_tracking_on_for_procedure(p_procedure_name in varchar2)
    return boolean
    is
        l_procedure_count integer;
    begin
        select count(*)
        into   l_procedure_count
        from   log_procedure_name lpn
        where  lpn.procedure_name = upper(p_procedure_name);

        return l_procedure_count > 0;
    end;

    procedure set_tracking_on_for_procedure(p_procedure_name in varchar2)
    is
    begin
        if (p_procedure_name is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, 'Не указано имя процедуры для отслеживания');
        end if;

        if (is_tracking_on_for_procedure(p_procedure_name)) then
            return;
        end if;

        insert into log_procedure_name
        values (upper(p_procedure_name));
    end;

    procedure set_tracking_off_for_procedure(p_procedure_name in varchar2)
    is
    begin
        delete log_procedure_name lpn
        where lpn.procedure_name = upper(p_procedure_name);
    end;

    function is_need_do_log(
        p_procedure_name in varchar2,
        p_log_level in integer)
    return boolean
    is
    begin
        return is_logging_on and
               p_log_level <= get_log_level() and
               (is_total_logging_on or is_tracking_on_for_procedure(p_procedure_name));
    end;

    procedure log(
        p_procedure_name in varchar2,
        p_log_level      in integer,
        p_log_message    in clob)
    is pragma autonomous_transaction;
    begin
        if (is_need_do_log(p_procedure_name, p_log_level)) then
            insert into log_table
            values (SYS_CONTEXT('USERENV', 'SESSIONID'),
                    p_procedure_name,
                    p_log_level,
                    p_log_message,
                    systimestamp);
            commit;
        end if;
    end;

    procedure log(
        p_procedure_name in varchar2,
        p_log_message    in clob)
    is pragma autonomous_transaction;
    begin
        if (is_need_do_log(p_procedure_name, g_log_level)) then
            insert into log_table
            values (SYS_CONTEXT('USERENV', 'SESSIONID'),
                    p_procedure_name,
                    g_log_level,
                    p_log_message,
                    systimestamp);
            commit;
        end if;
    end;

begin
    g_log_level := logger.LOG_LEVEL_DEBUG;
end logger;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/logger.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 