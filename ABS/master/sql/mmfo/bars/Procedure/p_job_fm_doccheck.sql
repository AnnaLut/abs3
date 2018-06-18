

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_JOB_FM_DOCCHECK.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_JOB_FM_DOCCHECK ***

CREATE OR REPLACE PROCEDURE BARS.P_JOB_FM_DOCCHECK 
is
begin
  begin
     p_fm_intdoccheck_tmp(null);
     commit;
  exception when others then
     bars_audit.error('FM. job: error during execution procedure p_fm_intdoccheck: ' ||
                      dbms_utility.format_error_stack() || chr(10) ||
                      dbms_utility.format_error_backtrace());
  end;
  begin
     p_fm_extdoccheck_tmp(null);
     commit;
  exception when others then
     bars_audit.error('FM. job: error during execution procedure p_fm_extdoccheck: ' ||
                      dbms_utility.format_error_stack() || chr(10) ||
                      dbms_utility.format_error_backtrace());
  end;
end;
/
show err;

PROMPT *** Create  grants  P_JOB_FM_DOCCHECK ***
grant EXECUTE                                                                on P_JOB_FM_DOCCHECK to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_JOB_FM_DOCCHECK.sql =========***
PROMPT ===================================================================================== 
