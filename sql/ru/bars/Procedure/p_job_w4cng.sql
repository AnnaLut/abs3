

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_JOB_W4CNG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_JOB_W4CNG ***

  CREATE OR REPLACE PROCEDURE BARS.P_JOB_W4CNG (p_id number)
is
  l_status number;
  h varchar2(100) := 'way4. p_job_w4cng. ';
begin

  bars_audit.info(h||'Start.');

  for z in ( select id from ow_files
              where file_type = 'CNGEXPORT' and file_status = 0
                and (p_id is null or id = p_id)
              order by file_name )
  loop
     bars_audit.info(h||'id=>'||z.id);
     p_job_w4importfiles(z.id);
  end loop;

  bars_audit.info(h||'Finish');

exception when others then
  bars_audit.info(h||
        dbms_utility.format_error_stack() || chr(10) ||
        dbms_utility.format_error_backtrace());
  raise_application_error(-20000,
        dbms_utility.format_error_stack() || chr(10) ||
        dbms_utility.format_error_backtrace());
end p_job_w4cng;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_JOB_W4CNG.sql =========*** End *
PROMPT ===================================================================================== 
