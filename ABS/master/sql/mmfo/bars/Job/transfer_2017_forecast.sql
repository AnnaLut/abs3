begin
  
  begin
    SYS.DBMS_SCHEDULER.DROP_JOB( job_name  => 'TRANSFER_FORECAST_NEW' );
  exception
    when others then
      null;
  end;
  
  SYS.DBMS_SCHEDULER.CREATE_JOB
  ( job_name        => 'TRANSFER_FORECAST_NEW'
  , start_date      => sysdate
  , repeat_interval => 'FREQ=HOURLY;'
  , job_class       => 'DEFAULT_JOB_CLASS'
  , job_type        => 'PLSQL_BLOCK'
  , job_action      => 'begin p_transform_forecast_newacc; end;'
  , comments        => 'Джоб для внесения прогнозируемых счетов'
  , enabled         => true
  );
  
  
end;
/
