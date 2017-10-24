

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/W4_IMPORT_MOBILE_FILE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure W4_IMPORT_MOBILE_FILE ***

  CREATE OR REPLACE PROCEDURE BARS.W4_IMPORT_MOBILE_FILE (p_filename varchar2,
                                                   p_filebody blob,
                                                   p_fileid   out number,
                                                   p_msg      out varchar2) is
  l_cnt integer;
begin

  if instr(p_filename, 'CL_INFO') > 0 then
    bars_ow.web_import_files(p_filename => p_filename,
                             p_filebody => p_filebody,
                             p_fileid   => p_fileid,
                             p_msg      => p_msg);
    if p_msg is null then
      p_job_w4importfiles(p_id => p_fileid);

      select t.err_text into p_msg from ow_files t where t.id = p_fileid;
      if p_msg is null then
        select count(*)
          into l_cnt
          from ow_cl_info_data_error t
         where t.file_name = p_filename;
        if l_cnt > 0 then
          p_msg := l_cnt ||' записів оброблено з помилками. Перевірте журнал.';
        end if;
      end if;
    end if;
  else
    p_msg := 'Невірний тип файлу';
  end if;
end;
/
show err;

PROMPT *** Create  grants  W4_IMPORT_MOBILE_FILE ***
grant EXECUTE                                                                on W4_IMPORT_MOBILE_FILE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/W4_IMPORT_MOBILE_FILE.sql ========
PROMPT ===================================================================================== 
