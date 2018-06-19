CREATE OR REPLACE PROCEDURE P_JOB_FM_DOCCHECK_EXT
is
begin
     p_fm_extdoccheck_tmp(null);
     commit;
  exception when others then
     bars_audit.error('FM. job: error during execution procedure p_fm_extdoccheck: ' ||
                      dbms_utility.format_error_stack() || chr(10) ||
                      dbms_utility.format_error_backtrace());
end;
/
