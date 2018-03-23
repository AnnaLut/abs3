prompt ====================================
prompt Create job EBK_CLOSED_CARD_JOB
prompt ====================================
begin
  
  begin
    SYS.DBMS_SCHEDULER.DROP_JOB( job_name => 'BARS.EBK_CLOSED_CARD_JOB' );
  exception
    when others then
      null;
  end;
  
  sys.dbms_scheduler.create_job
  ( job_name        => 'EBK_CLOSED_CARD_JOB'
  , start_date      => to_timestamp_tz('2015/06/17 11:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
  , repeat_interval => 'FREQ=DAILY; BYHOUR=11,15,18'
  , end_date        => null
  , job_class       => 'DEFAULT_JOB_CLASS'
  , job_type        => 'STORED_PROCEDURE'
  , job_action      => 'BARS.EBK_SENDCLOSEDCARD'
  , comments        => 'Джоб для запуска веб-сервиса SendCardClose'
  , enabled         => true
  );
  
--sys.dbms_scheduler.disable(name => 'EBK_CLOSED_CARD_JOB');
  
end;
/

