

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_XADATA.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_XADATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_XADATA ("FILE_NAME", "ACC", "NLS", "REGNUMBER", "RNK", "RESP_CLASS", "RESP_CODE", "RESP_TEXT", "UNFORM_FLAG", "UNFORM_USER", "FIO", "UNFORM_DATE") AS 
  select x.file_name, x.acc, a.nls, x.regnumber, a.rnk,
       x.resp_class, x.resp_code, x.resp_text,
       nvl(x.unform_flag,0), x.unform_user, s.fio, x.unform_date
  from ow_xadata x, staff$base s, accounts a
 where x.unform_user = s.id(+)
   and x.acc = a.acc;

PROMPT *** Create  grants  V_OW_XADATA ***
grant SELECT                                                                 on V_OW_XADATA     to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_XADATA     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_XADATA     to OW;
grant SELECT                                                                 on V_OW_XADATA     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_XADATA.sql =========*** End *** ==
PROMPT ===================================================================================== 
