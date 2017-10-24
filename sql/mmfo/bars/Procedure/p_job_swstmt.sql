

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_JOB_SWSTMT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_JOB_SWSTMT ***

  CREATE OR REPLACE PROCEDURE BARS.P_JOB_SWSTMT 
is
begin

  bc.subst_mfo(getglobaloption('GLB-MFO'));

  bars_swift_msg.process_stmt_queue;

  bc.set_context;

exception when others then
  bc.set_context;
  bars_audit.info('p_job_swstmt. '||
        dbms_utility.format_error_stack() || chr(10) ||
        dbms_utility.format_error_backtrace());
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_JOB_SWSTMT.sql =========*** End 
PROMPT ===================================================================================== 
