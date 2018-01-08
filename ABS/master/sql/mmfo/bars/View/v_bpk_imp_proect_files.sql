

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_IMP_PROECT_FILES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_IMP_PROECT_FILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_IMP_PROECT_FILES ("ID", "FILE_NAME", "FILE_DATE", "PRODUCT_ID", "ROWS_ALL", "ROWS_GOOD", "ROWS_BAD", "ROWS_ERR") AS 
  select id, file_name, file_date, product_id,
       (select count(*) from bpk_imp_proect_data where id = i.id),
       (select count(*) from bpk_imp_proect_data where id = i.id and rnk is not null),
       (select count(*) from bpk_imp_proect_data where id = i.id and rnk is null),
       (select count(*) from bpk_imp_proect_data where id = i.id and str_err is not null)
from bpk_imp_proect_files i;

PROMPT *** Create  grants  V_BPK_IMP_PROECT_FILES ***
grant SELECT                                                                 on V_BPK_IMP_PROECT_FILES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_IMP_PROECT_FILES to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_IMP_PROECT_FILES.sql =========***
PROMPT ===================================================================================== 
