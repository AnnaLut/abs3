

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_JOB_BPK_W4ATRTOARC.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_JOB_BPK_W4ATRTOARC ***

  CREATE OR REPLACE PROCEDURE BARS.P_JOB_BPK_W4ATRTOARC 
is
  h varchar2(100) := 'p_job_bpk_w4atrtoarc. ';
begin

  bars_audit. info(h || 'Start.');

  bc.subst_mfo(getglobaloption('GLB-MFO'));

  for z in ( select f.id
               from ow_files f
              where -- данные от 10 дней
                    f.file_date < sysdate - 10
                 -- нет необработанных документов
                and exists ( select 1 from ow_oic_atransfers_hist where id = f.id )
                 -- все файлы за эту дату обработаны
                and not exists ( select 1 from ow_oic_atransfers_data d, ow_files s where d.id = s.id and trunc(s.file_date) = trunc(f.file_date) ) )
  loop
     delete from ow_oic_atransfers_hist where id = z.id;
  end loop;
  commit;

  delete from ow_impfile;
  commit;

  bc.set_context;

  bars_audit. info(h || 'Finish.');

exception
  when others then
     bars_audit.error(h || 'error: ' ||
                      dbms_utility.format_error_stack() || chr(10) ||
                      dbms_utility.format_error_backtrace());
     bc.set_context;
     rollback;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_JOB_BPK_W4ATRTOARC.sql =========
PROMPT ===================================================================================== 
