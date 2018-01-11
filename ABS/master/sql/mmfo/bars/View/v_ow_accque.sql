

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_ACCQUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_ACCQUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_ACCQUE ("ACC", "BRANCH", "NLS", "KV", "NMS", "S", "DAT", "SOS", "STATUS", "F_N", "F_D") AS 
  select q.acc, a.branch, a.nls, a.kv, a.nms, q.s/100, q.dat,
       q.sos, decode(q.sos, 0 , 'Очікує відправки', 'Очікує квитовки'), q.f_n, f.file_date
  from ow_acc_que q, accounts a, ow_iicfiles f
 where q.acc = a.acc
   and q.f_n = f.file_name(+);

PROMPT *** Create  grants  V_OW_ACCQUE ***
grant SELECT                                                                 on V_OW_ACCQUE     to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_ACCQUE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_ACCQUE     to OW;
grant SELECT                                                                 on V_OW_ACCQUE     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_ACCQUE.sql =========*** End *** ==
PROMPT ===================================================================================== 
