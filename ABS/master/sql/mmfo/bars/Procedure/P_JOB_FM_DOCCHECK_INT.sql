CREATE OR REPLACE PROCEDURE P_JOB_FM_DOCCHECK_INT
is
begin
     p_fm_intdoccheck_tmp(null);
     commit;
  exception when others then
     bars_audit.error('FM. job: error during execution procedure p_fm_intdoccheck: ' ||
                      dbms_utility.format_error_stack() || chr(10) ||
                      dbms_utility.format_error_backtrace());
end;
/

