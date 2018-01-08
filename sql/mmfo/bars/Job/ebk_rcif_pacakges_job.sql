prompt ====================================
prompt Create job EBK_RCIF_PACAKGES_JOB
prompt ====================================
begin
  
  begin
    SYS.DBMS_SCHEDULER.DROP_JOB( job_name  => 'EBK_RCIF_PACAKGES_JOB' );
  exception
    when others then
      null;
  end;
  
  SYS.DBMS_SCHEDULER.CREATE_JOB
  ( job_name        => 'EBK_RCIF_PACAKGES_JOB'
  , start_date      => to_timestamp_tz('2015/06/17 01:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
  , repeat_interval => 'FREQ=HOURLY;'
  , job_class       => 'DEFAULT_JOB_CLASS'
  , job_type        => 'PLSQL_BLOCK'
  , job_action      => 'begin ebk_SendCardPackages( p_action_name => ''SendRcif''
                          , p_cardsCount => null
                          , p_packSize   => ''1000'' ); end;'
  , comments        => 'Джоб для запуска веб-сервиса SendRcif'
  , enabled         => true
  );
  
--sys.dbms_scheduler.disable(name => 'EBK_RCIF_PACAKGES_JOB');
  
end;
/
