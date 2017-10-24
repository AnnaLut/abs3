prompt ====================================
prompt Create job EBKC_SEND_PRIV_CARDS
prompt ====================================
begin
  
  begin
    SYS.DBMS_SCHEDULER.DROP_JOB( job_name => 'EBKC_SEND_PRIV_CARDS' );
  exception
    when others then
      null;
  end;
  
  SYS.DBMS_SCHEDULER.CREATE_JOB
  ( job_name        => 'EBKC_SEND_PRIV_CARDS'
  , start_date      => to_timestamp_tz('2015/06/17 01:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
  , repeat_interval => 'FREQ=DAILY;'
  , end_date        => null
  , job_class       => 'DEFAULT_JOB_CLASS'
  , job_type        => 'PLSQL_BLOCK'
  , job_action      => 'begin ebk_SendCardPackages( p_action_name => ''SendCardPackagesPrivateEn''
                          , p_cardsCount => null
                          , p_packSize   => ''100'' ); end;'
  , comments        => '���� ��� ������� ������������ ������ ���'
  , enabled         => true
  );
  
--sys.dbms_scheduler.disable( name => 'EBKC_SEND_PRIV_CARDS' );
  
end;
/

