prompt ====================================
prompt Create job EBK_CARD_PACAKGES_JOB
prompt ====================================
begin
  
  begin
    SYS.DBMS_SCHEDULER.DROP_JOB( job_name  => 'EBK_CARD_PACAKGES_JOB' );
  exception
    when others then
      null;
  end;
  
  sys.dbms_scheduler.create_job
  ( job_name        => 'EBK_CARD_PACAKGES_JOB'
  , start_date      => to_timestamp_tz('2015/06/17 01:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
  , repeat_interval => 'FREQ=DAILY;'
  , end_date        => null
  , job_class       => 'DEFAULT_JOB_CLASS'
  , job_type        => 'PLSQL_BLOCK'
  , job_action      => 'begin ebk_SendCardPackages( p_action_name => ''SendCardPackages''
                          , p_cardsCount => null
                          , p_packSize   => ''100'' ); end;'
  , comments        => 'Джоб для запуска веб-сервиса SendCardPackages'
  , enabled         => true
  );
  
--sys.dbms_scheduler.disable( name => 'EBK_CARD_PACAKGES_JOB' );
  
end;
/

