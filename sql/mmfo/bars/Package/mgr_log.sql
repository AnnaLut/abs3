
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mgr_log.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MGR_LOG as
  /******************************************************************************
     NAME:       mgr_log
     PURPOSE:

     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        06/14/2016 serhii.bovkush       1. Created this package.
  ******************************************************************************/

    type t_process_stat_row is record
     (
      received      pls_integer := 0,
      rejected      pls_integer := 0,
      rule_rejected pls_integer := 0,
      processed     pls_integer := 0,
      inserted      pls_integer := 0,
      updated       pls_integer := 0,
      not_changed   pls_integer := 0
     );

    type t_process_stats is table of t_process_stat_row index by varchar2(100);

  ----------------------------------------------------------------------------------
  -- Constants
  ----------------------------------------------------------------------------------

  GC_LOG_TYPE           constant migration_log.log_type%type := 'MGR_INFO';
  GC_LOG_TYPE_ERROR     constant migration_log.log_type%type := 'MGR_ERROR';
  ----------------------------------------------------------------------------------

  function f_get_migration_id return number;
  function f_interval_to_second(int_duration interval day to second) return number;

  ------------------------------------------------------------------------

  procedure p_save_log(
                        ip_migration_id                     in varchar2
                       ,ip_table_name                       in varchar2
                       ,ip_operation                        in varchar2
                       ,ip_row_count                        in number
                       );

  procedure p_save_log(
                        ip_id                               in out number
                       ,ip_migration_id                     number  default 0 --
                       ,ip_migration_start_time             date default sysdate
                       ,ip_table_name                       varchar2 default null --
                       ,ip_operation                        varchar2 default null
                       ,ip_row_count                        number default 0
                       ,ip_task_start_time                  timestamp default current_timestamp
                       ,ip_task_end_time                    timestamp default current_timestamp
                       ,ip_time_duration                    interval day to second default null
                       ,ip_log_type                         varchar2 default mgr_log.gc_log_type
                       ,ip_log_message                      varchar2 default null
                       ,ip_error_message                    varchar2 default null
                       );

  ----------------------------------------------------------------
  procedure p_save_log_begin(
                              ip_log_type                   in varchar2 default mgr_log.gc_log_type
                             ,ip_migration_id               in number
                            );

  procedure p_save_log_finish(
                                ip_migration_id             in number
                               ,ip_row_count                in number default 0
                               ,ip_log_type                 in varchar2 default mgr_log.gc_log_type
                               ,ip_time_duration            in interval day to second default null
                              );

  procedure p_save_log_error(
                             ip_migration_id                number
                            ,ip_migration_start_time        date default sysdate
                            ,ip_table_name                  varchar2 default null
                            ,ip_operation                   varchar2
                            ,ip_row_count                   number default 0
                            ,ip_task_start_time             timestamp default current_timestamp
                            ,ip_task_end_time               timestamp default current_timestamp
                            ,ip_time_duration               interval day to second default null
                            ,ip_log_type                    varchar2 default mgr_log.gc_log_type_error
                            ,ip_log_message                 varchar2 default null
                            ,ip_error_message               varchar2 default null
                            );

  procedure p_save_log_info_mesg(
                                 ip_migration_id            number
                                ,ip_migration_start_time    date default sysdate
                                ,ip_table_name              varchar2
                                ,ip_operation               varchar2
                                ,ip_row_count               number default 0
                                ,ip_task_start_time         timestamp default current_timestamp
                                ,ip_task_end_time           timestamp default current_timestamp
                                ,ip_time_duration           interval day to second default null
                                ,ip_log_type                varchar2 default mgr_log.gc_log_type
                                ,ip_log_message             varchar2
                                );

  procedure p_set_action_info (ip_row_count in number);

----------------------------------------------------------------

end mgr_log;
/
CREATE OR REPLACE PACKAGE BODY BARS.MGR_LOG as
  /******************************************************************************
     NAME:       MGR_LOG
     PURPOSE:

     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        06/14/2016 serhii.bovkush       1. Created this package.
  ******************************************************************************/
  v_current_migration_id number := -1;

  -------------------------------------------------------------------------------
  function f_get_migration_id return number as
  begin
    select seq_migration_log_id.nextval
      into v_current_migration_id
      from dual;

    return v_current_migration_id;
  end f_get_migration_id;
  -------------------------------------------------------------------------------
  function f_interval_to_second(int_duration interval day to second)
    return number
  is
    nsecond number;
  begin
  nsecond := to_number(extract(second from int_duration)) +
             to_number(extract(minute from int_duration)) * 60 +
             to_number(extract(hour from int_duration)) * 60 * 60 +
             to_number(extract(day from int_duration)) * 60 * 60* 24;
  return(nsecond);
  end f_interval_to_second;

  -------------------------------------------------------------------------------
  procedure p_save_log(
                        ip_migration_id                     in varchar2
                       ,ip_table_name                       in varchar2
                       ,ip_operation                        in varchar2
                       ,ip_row_count                        in number
                       ) as
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(module_name => 'migration_id=' ||
                                                    to_char(ip_migration_id),
                                     action_name => ip_operation);

    insert into migration_log
      (id
       ,migration_id
       ,table_name
       ,operation
       ,row_count)
    values
      (seq_migration_log_id.nextval
       ,ip_migration_id
       ,ip_table_name
       ,ip_operation
       ,ip_row_count);

    commit;
  end p_save_log;

  -------------------------------------------------------------------------------
  procedure p_save_log(
                        ip_id                               in out number
                       ,ip_migration_id                     number  default 0
                       ,ip_migration_start_time             date default sysdate
                       ,ip_table_name                       varchar2 default null
                       ,ip_operation                        varchar2 default null
                       ,ip_row_count                        number default 0
                       ,ip_task_start_time                  timestamp default current_timestamp
                       ,ip_task_end_time                    timestamp default current_timestamp
                       ,ip_time_duration                    interval day to second default null
                       ,ip_log_type                         varchar2 default mgr_log.gc_log_type
                       ,ip_log_message                      varchar2 default null
                       ,ip_error_message                    varchar2 default null
                       ) as

    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(module_name => 'migration_id=' ||
                                                    to_char(ip_migration_id),
                                     action_name => ip_operation);

    if ip_id is null then
     ip_id := seq_migration_log_id.nextval;
    end if;

    insert into migration_log
        (id
        ,migration_id
        ,migration_start_time
        ,table_name
        ,operation
        ,row_count
        ,task_start_time
        ,task_end_time
        ,time_duration
        ,log_type
        ,log_message
        ,error_message)
    values
        (ip_id
         ,ip_migration_id
         ,ip_migration_start_time
         ,ip_table_name
         ,ip_operation
         ,ip_row_count
         ,ip_task_start_time
         ,ip_task_end_time
         ,ip_time_duration
         ,ip_log_type
         ,ip_log_message
         ,ip_error_message);

    commit;
  end p_save_log;


  -------------------------------------------------------------------------------
  procedure p_save_log(
                        ip_migration_id                     number  default 0 --
                       ,ip_migration_start_time             date default sysdate
                       ,ip_table_name                       varchar2 default null --
                       ,ip_operation                        varchar2 default null
                       ,ip_row_count                        number default 0
                       ,ip_task_start_time                  timestamp default current_timestamp
                       ,ip_task_end_time                    timestamp default current_timestamp
                       ,ip_time_duration                    interval day to second default null
                       ,ip_log_type                         varchar2 default mgr_log.gc_log_type
                       ,ip_log_message                      varchar2 default null
                       ,ip_error_message                    varchar2 default null
                       ) as

    l_id migration_log.id%type;
  begin

    l_id := null;

    mgr_log.p_save_log(
                        ip_id                               => l_id
                       ,ip_migration_id                     => ip_migration_id
                       ,ip_migration_start_time             => ip_migration_start_time
                       ,ip_table_name                       => ip_table_name
                       ,ip_operation                        => ip_operation
                       ,ip_row_count                        => ip_row_count
                       ,ip_task_start_time                  => ip_task_start_time
                       ,ip_task_end_time                    => ip_task_end_time
                       ,ip_time_duration                    => ip_time_duration
                       ,ip_log_type                         => ip_log_type
                       ,ip_log_message                      => ip_log_message
                       ,ip_error_message                    => ip_error_message
                        );
  end;


  -------------------------------------------------------------------------------
  procedure p_save_log_begin(
                              ip_log_type                   in varchar2 default mgr_log.gc_log_type
                             ,ip_migration_id               in number
                            )
  is
  begin
    mgr_log.p_save_log (
                         ip_migration_id                    => ip_migration_id
                        ,ip_operation                       => 'Begin'
                        ,ip_row_count                       => 0
                        ,ip_log_type                        => ip_log_type
                        );
  end;


  ----------------------------------------------------------------------------------
  procedure p_save_log_finish (
                                ip_migration_id             in number
                                ,ip_row_count               in number default 0
                                ,ip_log_type                in varchar2 default mgr_log.gc_log_type
                                ,ip_time_duration           in interval day to second default null
                               )
  is
  begin
    mgr_log.p_save_log (
                         ip_migration_id                    => ip_migration_id
                        ,ip_operation                       => 'Finished'
                        ,ip_row_count                       => ip_row_count
                        ,ip_log_type                        => ip_log_type
                        ,ip_time_duration                   => ip_time_duration
                        );
  end;


  ----------------------------------------------------------------------------------
  procedure p_save_log_error(
                             ip_migration_id                number
                            ,ip_migration_start_time        date default sysdate
                            ,ip_table_name                  varchar2 default null
                            ,ip_operation                   varchar2
                            ,ip_row_count                   number default 0
                            ,ip_task_start_time             timestamp default current_timestamp
                            ,ip_task_end_time               timestamp default current_timestamp
                            ,ip_time_duration               interval day to second default null
                            ,ip_log_type                    varchar2 default mgr_log.gc_log_type_error
                            ,ip_log_message                 varchar2 default null
                            ,ip_error_message               varchar2 default null
                            )
  is
    l_id migration_log.id%type;
  begin

    l_id := null;
    --g_kf := mgr_utl.get_kf();

    mgr_log.p_save_log (
                         ip_id                              => l_id
                        ,ip_migration_id                    => ip_migration_id
                        ,ip_table_name                      => ip_table_name
                        ,ip_operation                       => 'Finished with error: ' || to_char (ip_operation)
                        ,ip_row_count                       => ip_row_count
                        ,ip_log_type                        => ip_log_type
                        ,ip_log_message                     => ip_log_message
                        ,ip_error_message                   => 'Finished with error: ' ||  SUBSTR('format_call_stack: ' ||DBMS_UTILITY.FORMAT_CALL_STACK    ||CHR(10)||
                                                                                      'format_error_backtrace: '    ||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE   ||CHR(10)||
                                                                                      'format_error_stack : '   ||DBMS_UTILITY.FORMAT_ERROR_STACK
                                                                                        ,1,3500)
                        );
 end;

  ----------------------------------------------------------------------------------
  procedure p_save_log_info_mesg(
                                 ip_migration_id            number
                                ,ip_migration_start_time    date default sysdate
                                ,ip_table_name              varchar2
                                ,ip_operation               varchar2
                                ,ip_row_count               number default 0
                                ,ip_task_start_time         timestamp default current_timestamp
                                ,ip_task_end_time           timestamp default current_timestamp
                                ,ip_time_duration           interval day to second default null
                                ,ip_log_type                varchar2 default mgr_log.gc_log_type
                                ,ip_log_message             varchar2
                                ) is
  begin
    mgr_log.p_save_log (
                        ip_migration_id                     => ip_migration_id
                       ,ip_migration_start_time             => ip_migration_start_time
                       ,ip_table_name                       => ip_table_name
                       ,ip_operation                        => ip_operation
                       ,ip_row_count                        => ip_row_count
                       ,ip_task_start_time                  => ip_task_start_time
                       ,ip_task_end_time                    => ip_task_end_time
                       ,ip_time_duration                    => ip_time_duration
                       ,ip_log_type                         => ip_log_type
                       ,ip_log_message                      => ip_log_message
                       );
  end;


----------------------------------------------------------------------------------
  procedure p_set_action_info (ip_row_count in number)
  is
  begin
    dbms_application_info.set_action ('l_curr_row_num= ' || to_char (ip_row_count));
  end;
----------------------------------------------------------------

end mgr_log;
/
 show err;
 
PROMPT *** Create  grants  MGR_LOG ***
grant EXECUTE                                                                on MGR_LOG         to FINMON;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mgr_log.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 