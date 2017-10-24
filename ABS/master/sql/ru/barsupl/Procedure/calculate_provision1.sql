

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Procedure/CALCULATE_PROVISION1.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CALCULATE_PROVISION1 ***

CREATE OR REPLACE procedure BARSUPL.CALCULATE_PROVISION1
( p_date     in   bars.nbu23_rez.fdat%type,
  p_kf       in   varchar2
) is
  -- ver 2.1   27/02/2017
  -- ver 2.2   04/05/2017 - добавлен параметр p_kf
  l_calc_dt    bars.nbu23_rez.fdat%type;
  l_calc       varchar2(10);
begin
  l_calc_dt := nvl(p_date,trunc(sysdate,'MM'));
  l_calc    := to_char(l_calc_dt,'dd-mm-yyyy');

  dbms_application_info.set_action('CALCULATE_PROVISION1');
  --BARS.TUDA;
  BARS.BC.GO(p_kf);
  BARS.GL.SETP('RESERVE',SYS_CONTEXT('USERENV','SID'),NULL);
  BARS.BARS_UTL_SNAPSHOT.START_RUNNING;

  dbms_application_info.set_client_info('Z23.START_REZ('||l_calc ||',0);');   -- 00.Стартовые работы Перенесення поточних ГПК в архiв
  BARS.Z23.START_REZ(to_date(l_calc,'dd-mm-yyyy'),0);
  dbms_application_info.set_client_info('P_2401('||l_calc ||');');            -- 01.Розподіл фін.актівів на суттєві та несуттєві
  BARS.P_2401(to_date(l_calc,'dd-mm-yyyy'));

  dbms_application_info.set_client_info(NULL);
  dbms_application_info.set_action(NULL);
  BARS.BARS_UTL_SNAPSHOT.STOP_RUNNING;
  BARS.GL.SETP('RESERVE','',NULL);

  bars_audit.info( 'CALCULATE_PROVISION1 - OK');
exception
  when OTHERS then
    BARS.BARS_UTL_SNAPSHOT.STOP_RUNNING;
    BARS.GL.SETP('RESERVE','',NULL);
    dbms_application_info.set_action(NULL);
    dbms_application_info.set_client_info(NULL);
    bars_audit.info( 'CALCULATE_PROVISION1 exit with ERROR: ' ||
                     dbms_utility.format_error_stack() || chr(10) ||
                     dbms_utility.format_error_backtrace() );
    BARS.Z23.TO_LOG_REZ( BARS.GL.aUID, -999, to_date(''||l_calc||'','dd-mm-yyyy'), SubStr(SQLERRM,1,100) );
    RAISE;
end CALCULATE_PROVISION1;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Procedure/CALCULATE_PROVISION1.sql ======
PROMPT ===================================================================================== 
