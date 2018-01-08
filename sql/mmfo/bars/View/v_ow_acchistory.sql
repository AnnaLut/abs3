

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_ACCHISTORY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_ACCHISTORY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_ACCHISTORY ("ACC", "BRANCH", "NLS", "KV", "NMS", "S", "DAT", "F_N", "F_D", "K_DATE", "K_DONEBY", "K_FIO", "RESP_CLASS", "RESP_CODE", "RESP_TEXT") AS 
  select q.acc, a.branch, a.nls, a.kv, a.nms, q.s/100, q.dat,
       q.f_n, f.file_date, q.k_date, q.k_doneby, s.fio,
       q.resp_class, q.resp_code, q.resp_text
  from ow_acc_history q, accounts a, staff$base s, ow_iicfiles f
  where q.acc = a.acc
    and q.k_doneby = s.logname
    and q.f_n = f.file_name;

PROMPT *** Create  grants  V_OW_ACCHISTORY ***
grant SELECT                                                                 on V_OW_ACCHISTORY to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_ACCHISTORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_ACCHISTORY to OW;
grant SELECT                                                                 on V_OW_ACCHISTORY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_ACCHISTORY.sql =========*** End **
PROMPT ===================================================================================== 
