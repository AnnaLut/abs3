

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CASH_ISP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CASH_ISP ***

  CREATE OR REPLACE FORCE VIEW BARS.CASH_ISP ("ISP", "FIO", "NLS", "NMS") AS 
  select a.isp, s.fio, a.nls, a.nms from accounts a,  staff s
where a.kv=980 and a.isp=s.id and a.tip='KAS' and a.dazs is null
 ;

PROMPT *** Create  grants  CASH_ISP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CASH_ISP        to ABS_ADMIN;
grant SELECT                                                                 on CASH_ISP        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CASH_ISP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_ISP        to PYOD001;
grant SELECT                                                                 on CASH_ISP        to START1;
grant SELECT                                                                 on CASH_ISP        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CASH_ISP        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CASH_ISP.sql =========*** End *** =====
PROMPT ===================================================================================== 
