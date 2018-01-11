

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Procedure/CALCULATE_PROVISION.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CALCULATE_PROVISION ***

  CREATE OR REPLACE PROCEDURE BARSUPL.CALCULATE_PROVISION 
( p_date  in   bars.nbu23_rez.fdat%type,
  p_kf    in   varchar2
) is
  --
  -- ver 2.0   30/01/2017
  -- ver 2.1   04/05/2017 - добавлен параметр p_kf
  l_calc_dt      bars.nbu23_rez.fdat%type;
  l_calc         varchar2(10);
  l_stmt         varchar2(32000);
  l_region_code  barsupl.upl_regions.code_chr%type;
begin
  l_calc_dt := nvl(p_date,trunc(sysdate,'MM'));
  l_calc    := to_char(l_calc_dt,'dd-mm-yyyy');
    select CODE_CHR
     into l_region_code
      from barsupl.UPL_REGIONS
     where kf = p_kf;

  l_stmt := 'BEGIN'||chr(10);
--l_stmt := l_stmt || '  execute immediate ''ALTER SESSION ENABLE PARALLEL DML'';'                   ||chr(10);
  l_stmt := l_stmt || '  dbms_application_info.set_action(''CALCULATE_PROVISION_' || l_region_code || ''');'                ||chr(10);
  l_stmt := l_stmt || '  bars.bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),'       ||chr(10);
  l_stmt := l_stmt || '                             p_userid    => '|| bars.gl.aUID ||','            ||chr(10);
  l_stmt := l_stmt || '                             p_hostname  => null,'                            ||chr(10);
  l_stmt := l_stmt || '                             p_appname   => ''UPLD:CALCULATE_PROVISION_'|| l_region_code ||''');'    ||chr(10);
  l_stmt := l_stmt || '  BARS.BC.GO('''|| p_kf ||'''); '                                             ||chr(10);
  --l_stmt := l_stmt || '  BARS.GL.SETP(''RESERVE'',SYS_CONTEXT(''USERENV'',''SID''),NULL);'           ||chr(10);
  --l_stmt := l_stmt || '  BARS.BARS_UTL_SNAPSHOT.START_RUNNING;'                                      ||chr(10);
  l_stmt := l_stmt || '  --- '                                                                       ||chr(10);
  l_stmt := l_stmt || '  dbms_application_info.set_client_info(''Z23.ZALOG('||l_calc ||');'');'      ||chr(10);
  l_stmt := l_stmt || '  BARS.Z23.ZALOG(to_date(''' || l_calc ||''',''dd-mm-yyyy''));'               ||chr(10);  -- 05.Розрахунок ЗАБЕЗПЕЧЕННЯ
  l_stmt := l_stmt || '  dbms_application_info.set_client_info(''BARS.CR('||l_calc ||');'');'        ||chr(10);
  l_stmt := l_stmt || '  BARS.CR(to_date(''' || l_calc ||''',''dd-mm-yyyy''));'                      ||chr(10);  -- Розрахунок кредитного ризику (351)

  l_stmt := l_stmt || '  dbms_application_info.set_client_info(NULL);'                               ||chr(10);
  l_stmt := l_stmt || '  dbms_application_info.set_action(NULL);'                                    ||chr(10);
  l_stmt := l_stmt || '  -- '                                                                        ||chr(10);
  --l_stmt := l_stmt || '  BARS.BARS_UTL_SNAPSHOT.STOP_RUNNING;'                                       ||chr(10);
  --l_stmt := l_stmt || '  BARS.GL.SETP(''RESERVE'','''',NULL);'                                       ||chr(10);
  l_stmt := l_stmt || 'EXCEPTION'                                                                    ||chr(10);
  l_stmt := l_stmt || '  when OTHERS then'                                                           ||chr(10);
  --l_stmt := l_stmt || '    BARS.BARS_UTL_SNAPSHOT.STOP_RUNNING;'                                     ||chr(10);
  --l_stmt := l_stmt || '    BARS.GL.SETP(''RESERVE'','''',NULL);'                                     ||chr(10);
  l_stmt := l_stmt || '    dbms_application_info.set_action(NULL);'                                  ||chr(10);
  l_stmt := l_stmt || '    dbms_application_info.set_client_info(NULL);'                             ||chr(10);
  l_stmt := l_stmt || '    BARS.BARS_AUDIT.INFO( ''CALCULATE_PROVISION_' || l_region_code || ' ERROR: ''||'                  ||chr(10);
  l_stmt := l_stmt || '                          dbms_utility.format_error_stack()||chr(10)||'       ||chr(10);
  l_stmt := l_stmt || '                          dbms_utility.format_error_backtrace() );'           ||chr(10);
  l_stmt := l_stmt || '    BARS.Z23.TO_LOG_REZ( BARS.GL.aUID, -999, to_date('''||l_calc||''',''dd-mm-yyyy''), SubStr(SQLERRM,1,100) );' ||chr(10);
  l_stmt := l_stmt || 'END;';

  bars_audit.info( 'CALCULATE_PROVISION_' || l_region_code || ' stmt ='||chr(10)||l_stmt );

  begin
    select CODE_CHR
     into l_region_code
      from barsupl.UPL_REGIONS
     where kf = p_kf;

    SYS.DBMS_SCHEDULER.CREATE_JOB
    ( job_name   => 'JOB$CALCULATE_PROVISION_' || l_region_code
    , job_type   => 'PLSQL_BLOCK'
    , job_action => l_stmt
    , start_date => SYSTIMESTAMP + INTERVAL '3' SECOND
    , enabled    => TRUE );
  exception
    when OTHERS then
      if ( sqlcode = -27477 )
      then
        -- drop old job
        SYS.DBMS_SCHEDULER.DROP_JOB
        ( job_name  => 'JOB$CALCULATE_PROVISION_' || l_region_code
        , force     => TRUE );

        -- create new job
        CALCULATE_PROVISION( p_date, p_kf );
      else
        raise;
      end if;
  end;

  bars_audit.info( 'CALCULATE_PROVISION_' || l_region_code || ': job created.' );

exception
  when OTHERS then
    bars_audit.info( 'CALCULATE_PROVISION_' || l_region_code || ' exit with ERROR: ' ||
                     dbms_utility.format_error_stack() || chr(10) ||
                     dbms_utility.format_error_backtrace() );
    RAISE;
end CALCULATE_PROVISION;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Procedure/CALCULATE_PROVISION.sql =======
PROMPT ===================================================================================== 
