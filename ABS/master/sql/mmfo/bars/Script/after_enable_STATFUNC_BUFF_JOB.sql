begin
SYS.DBMS_SCHEDULER.ENABLE
   (name                  => 'BARS.STATFUNC_BUFF_JOB');
end;
/

commit;