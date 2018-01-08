

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_OUT_FILES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_OUT_FILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_OUT_FILES ("FILE_NAME", "FILE_DATE", "FILE_N", "FILE_S") AS 
  select i.file_name, i.file_date, i.file_n, i.file_s
    from ow_iicfiles i
  union all
    select o.file_name, o.file_date, o.file_n, o.file_s
    from ow_oicrevfiles o;

PROMPT *** Create  grants  V_OW_OUT_FILES ***
grant SELECT                                                                 on V_OW_OUT_FILES  to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_OUT_FILES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_OUT_FILES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_OUT_FILES.sql =========*** End ***
PROMPT ===================================================================================== 
