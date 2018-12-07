

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_JOB_W4IMPORTFILES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_JOB_W4IMPORTFILES ***

  CREATE OR REPLACE PROCEDURE BARS.P_JOB_W4IMPORTFILES (p_id number)
is
  l_status   number;
  l_bankdate date;
  l_userid   number;
  h varchar2(100) := 'p_job_w4importfiles. ';

  function lock_file (p_id in number, p_status in number) return boolean
  is
     l_id   number;
     b_lock boolean;
  begin
     begin
        select id into l_id from ow_files where id = p_id and file_status = p_status for update skip locked;
        b_lock := true;
     exception when no_data_found then
        b_lock := false;
     end;
     return b_lock;
  end;

begin

  bars_audit.info(h || 'Start.');

  l_bankdate := gl.bdate;

  bc.subst_mfo(getglobaloption('MFO'));

  gl.bdate := l_bankdate;
  l_userid := user_id;

  for z in ( select f.id, f.file_type, f.file_name, f.file_status, f.origin, nvl(t.type,0) type
               from ow_files f, ow_file_type t
              where f.file_type = t.file_type
                and t.io = 'I'
                and ( p_id is null and f.origin = 1 and f.file_status in (0, 1)
                   or f.id = p_id and f.file_status in (0, 1, 2) )
              order by t.priority, f.id )
  loop

     bars_audit. info(h || 'Loading file ' || z.file_name);


     if z.file_status = 0 then

        if lock_file(z.id, z.file_status) = true then
           ow_files_proc.parse_file(z.id);
        else
           bars_audit.info(h || 'File ' || z.file_name || ' is processed by another application');
           if p_id is not null then
              raise_application_error(-20000, 'File ' || z.file_name || ' is processed by another application');
           end if;
        end if;

     end if;

     if z.type = 1 then

        select file_status into l_status from ow_files where id = z.id;


        if l_status in (1, 2) then


           if p_id is null and z.origin = 1 then
              begin
                 select id into gl.aUID from staff$base where logname = 'TECH_BPK';
              exception when no_data_found then
                 bars_audit.info(h || 'User TECH_BPK not found.');
              end;
           end if;

           if lock_file(z.id, l_status) = true then
              bars_ow.pay_oic_file(z.id);
           else
              bars_audit.info(h || 'File ' || z.file_name || ' is processed by another application');
              if p_id is not null then
                 raise_application_error(-20000, 'File ' || z.file_name || ' is processed by another application');
              end if;
           end if;

        end if;

     end if;


  end loop;

  gl.aUID := l_userid;

  bc.set_context;

  bars_audit.info(h || 'Finish.');

exception
  when others then
     rollback;
     gl.aUID := l_userid;
     bc.set_context;
     bars_audit.error(h || 'error: ' ||
                      dbms_utility.format_error_stack() || chr(10) ||
                      dbms_utility.format_error_backtrace());
     if p_id is not null then
        raise_application_error(-20000,
           dbms_utility.format_error_stack() || chr(10) ||
           dbms_utility.format_error_backtrace());
     end if;
end p_job_w4importfiles;
/
show err;

PROMPT *** Create  grants  P_JOB_W4IMPORTFILES ***
grant EXECUTE                                                                on P_JOB_W4IMPORTFILES to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_JOB_W4IMPORTFILES to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_JOB_W4IMPORTFILES.sql =========*
PROMPT ===================================================================================== 
