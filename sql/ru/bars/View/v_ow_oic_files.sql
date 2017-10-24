

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_OIC_FILES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_OIC_FILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_OIC_FILES ("ID", "FILE_TYPE", "FILE_NAME", "FILE_DATE", "FILE_STATUS", "ERR_TEXT", "FILE_N", "N_OPL", "N_ERR", "N_DEL", "N_ABS") AS 
  select id, file_type, file_name, file_date, file_status, err_text, file_n,
       file_n - n_err - n_del n_opl, n_err, n_del, n_abs
  from (
select f.id, f.file_type, f.file_name, f.file_date, f.file_status, f.err_text, f.file_n,
       (select count(*) from ow_oic_atransfers_data where id = f.id) n_err,
       (select count(*) from v_ow_oic_atransfers_hist where id = f.id and ref is null) n_del,
       (select count(*) from ow_oic_ref where id = f.id) n_abs
  from ow_files f
 where f.file_type in ('ATRANSFERS', 'FTRANSFERS')
 union all
select f.id, f.file_type, f.file_name, f.file_date, f.file_status, f.err_text, f.file_n,
       (select count(*) from ow_oic_stransfers_data where id = f.id) n_err,
       (select count(*) from ow_oic_stransfers_hist where id = f.id) n_del,
       (select count(*) from ow_oic_ref where id = f.id) n_abs
  from ow_files f
 where f.file_type = 'STRANSFERS'
 union all
select f.id, f.file_type, f.file_name, f.file_date, f.file_status, f.err_text, f.file_n,
       (select count(*) from ow_oic_documents_data where id = f.id) n_err,
       (select count(*) from ow_oic_documents_hist where id = f.id) n_del,
       (select count(*) from ow_oic_ref where id = f.id) n_abs
  from ow_files f
 where f.file_type = 'DOCUMENTS' );

PROMPT *** Create  grants  V_OW_OIC_FILES ***
grant SELECT                                                                 on V_OW_OIC_FILES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_OIC_FILES  to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_OIC_FILES.sql =========*** End ***
PROMPT ===================================================================================== 
