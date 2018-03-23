begin
SYS.DBMS_SCHEDULER.DISABLE
   (name                  => 'BARS.STATFUNC_BUFF_JOB', FORCE => TRUE);
end;
/

commit;

TRUNCATE TABLE ui_func_stats_buff;