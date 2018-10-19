PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_check_file_in_queue.sql =========*** Run **
PROMPT ===================================================================================== 

create or replace function f_nbur_check_file_in_queue(
                              p_file_code in nbur_ref_files.file_code%type
                              , p_kf in nbur_lst_files.kf%type
                              , p_report_date in nbur_lst_files.report_date%type
                            ) return boolean
is
  l_count    number;
  l_file_id  nbur_ref_files.id%type := nbur_files.get_file_id(p_file_code);
begin
  select count(*)
    into
         l_count
  from   nbur_queue_forms f
  where  f.id = l_file_id
         and f.report_date = p_report_date
         and f.kf = p_kf
         and (f.status = 1 or
              exists (select 1
                      from nbur_lnk_files_files a, 
                           nbur_ref_procs b, 
                           nbur_ref_procs c
                      where a.file_id = l_file_id and
                            a.file_id = b.file_id and
                            a.file_dep_id = c.file_id and 
                            b.proc_type <> c.proc_type
                     )
             );

  return (l_count > 0);
exception
  when others then
    return false;
end f_nbur_check_file_in_queue;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_check_file_in_queue.sql =========*** End **
PROMPT ===================================================================================== 