PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_get_run_version.sql =========*** Run **
PROMPT ===================================================================================== 

create or replace function f_nbur_get_run_version(
                              p_file_code in nbur_ref_files.file_code%type
                              , p_kf in nbur_lst_files.kf%type
                              , p_report_date in nbur_lst_files.report_date%type
                            ) return nbur_lst_files.version_id%type
is
  l_result   nbur_lst_files.version_id%type;
  l_file_id  nbur_ref_files.id%type := nbur_files.get_file_id(p_file_code);
begin
  select max(version_id)
    into
         l_result
  from   nbur_lst_files f
  where	 f.report_date = p_report_date
         and f.kf = p_kf
         and f.file_id = l_file_id
         and f.file_status in ('RUNNING');

  return l_result;
exception
  when others then
    return null;
end f_nbur_get_run_version;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_get_run_version.sql =========*** End **
PROMPT ===================================================================================== 