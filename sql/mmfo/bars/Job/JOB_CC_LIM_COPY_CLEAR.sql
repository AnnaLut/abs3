begin 
   begin
    SYS.DBMS_SCHEDULER.DROP_JOB( job_name => 'JOB_CC_LIM_COPY_CLEAR' );
  exception
    when others then
      null;
  end;

begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.JOB_CC_LIM_COPY_CLEAR',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'BEGIN
  BEGIN
    execute_immediate(''delete from  CC_LIM_COPY_HEADER'');
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -942 THEN
        NULL;
      END IF;
  END;

  BEGIN
    execute_immediate(''truncate table CC_LIM_COPY_HEADER'');
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -942 THEN
        NULL;
      END IF;
  END;
END;',
                                start_date          => to_date('20-06-2017 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Monthly;ByMonthDay=10',
                                end_date            => to_date(null),
                                job_class           => 'DBMS_JOB$',
                                enabled             => true,
                                auto_drop           => true,
                                comments            => '');
end;
end;
/
