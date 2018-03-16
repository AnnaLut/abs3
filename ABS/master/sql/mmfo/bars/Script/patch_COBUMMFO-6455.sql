-------------------
-- COBUMMFO-6455 --
-------------------

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_DAILY_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_DAILY_ARCH', 'FILIAL',  'M',  'M',  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_DAILY_ARCH', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

commit;

begin
  BARS.BPA.ALTER_POLICIES( 'NBUR_DM_BALANCES_DAILY_ARCH' );
end;
/

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_MONTHLY_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_MONTHLY_ARCH', 'FILIAL',  'M',  'M',  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_MONTHLY_ARCH', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

commit;

begin
  BARS.BPA.ALTER_POLICIES( 'NBUR_DM_BALANCES_MONTHLY_ARCH' );
end;
/


begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_CLT_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_CLT_ARCH', 'FILIAL',  'M',  'M',  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DM_BALANCES_CLT_ARCH', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

commit;

begin
  BARS.BPA.ALTER_POLICIES( 'NBUR_DM_BALANCES_CLT_ARCH' );
end;
/

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DETAIL_PROTOCOLS_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DETAIL_PROTOCOLS_ARCH', 'FILIAL',  'M',  'M',  'E',  'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_DETAIL_PROTOCOLS_ARCH', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

commit;

begin
  BARS.BPA.ALTER_POLICIES( 'NBUR_DETAIL_PROTOCOLS_ARCH' );
end;
/

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_AGG_PROTOCOLS_ARCH', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_AGG_PROTOCOLS_ARCH', 'FILIAL',  'M',  'M',  'M',  'M' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_AGG_PROTOCOLS_ARCH', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

commit;

begin
  BARS.BPA.ALTER_POLICIES( 'NBUR_AGG_PROTOCOLS_ARCH' );
end;
/

declare
  e_job_exists           exception;
  pragma exception_init( e_job_exists, -27477 );
  l_stmt                 varchar2(2048);
begin

  l_stmt := 'BEGIN';
  l_stmt := l_stmt || chr(10) || '  NBUR_OBJECTS.REMOVE_OBSOLETE_VERSIONS;';
  l_stmt := l_stmt || chr(10) || '  NBUR_OBJECTS.REMOVE_INVALID_VERSIONS(null,null);';
  l_stmt := l_stmt || chr(10) || 'END;';

  bars_audit.info( 'REMOVE_DM_VERSIONS: '||chr(10)||l_stmt );
  
  DBMS_SCHEDULER.CREATE_JOB
  ( job_name   => 'REMOVE_DM_VERSIONS'
  , job_type   => 'PLSQL_BLOCK'
  , job_action => l_stmt
  , start_date => trunc(SYSTIMESTAMP) + INTERVAL '1' DAY + INTERVAL '2' HOUR
  , enabled    => TRUE );
  
  bars_audit.info( 'Job "REMOVE_DM_VERSIONS" created.' );

exception
  when e_job_exists 
  then dbms_output.put_line( 'Job "REMOVE_DM_VERSIONS" already exists.' );
end;
/

