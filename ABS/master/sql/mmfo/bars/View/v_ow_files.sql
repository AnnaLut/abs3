

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_FILES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_FILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_FILES ("ID", "FILE_TYPE", "FILE_NAME", "FILE_DATE", "FILE_STATUS", "ERR_TEXT", "FILE_N", "N_OPL", "N_ERR", "N_DEL", "N_ABS") AS 
  select id, file_type, file_name, file_date, file_status, err_text, file_n,
       n_opl, n_err, n_del, n_abs
  from v_ow_oic_files
 union all
select f.id, f.file_type, f.file_name, f.file_date, f.file_status, f.err_text, f.file_n,
       tick_accept_rec, tick_reject_rec, null, null
  from ow_files f, ow_iicfiles i
 where f.file_type = 'R_IIC_DOCUMENTS'
   and f.file_name = i.tick_name(+)
 union all
select id, file_type, file_name, file_date, file_status, err_text, file_n,
       null, null, null, null
  from ow_files
 where file_type not in ('ATRANSFERS', 'FTRANSFERS', 'STRANSFERS', 'DOCUMENTS', 'R_IIC_DOCUMENTS');

PROMPT *** Create  grants  V_OW_FILES ***
grant SELECT                                                                 on V_OW_FILES      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_FILES      to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_FILES.sql =========*** End *** ===
PROMPT ===================================================================================== 
