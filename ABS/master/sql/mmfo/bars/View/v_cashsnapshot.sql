

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CASHSNAPSHOT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CASHSNAPSHOT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CASHSNAPSHOT ("OPDATE", "SHIFT", "ACC", "NLS", "KV", "NMS", "OSTF") AS 
  select o.opdate, shift, s.acc, nls, kv, nms, decode(a.pap, 1, (-1), 1) * s.ostf
 from cash_open o, cash_snapshot s, accounts a
 where o.branch = s.branch
       and o.opdate = s.opdate
       and o.opdate between trunc(sysdate) and trunc(sysdate) + 0.999
       and s.acc = a.acc
       and o.branch = sys_context('bars_context','user_branch')
       and s.branch = o.branch
 ;

PROMPT *** Create  grants  V_CASHSNAPSHOT ***
grant SELECT                                                                 on V_CASHSNAPSHOT  to BARSREADER_ROLE;
grant SELECT                                                                 on V_CASHSNAPSHOT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CASHSNAPSHOT  to OPER000;
grant SELECT                                                                 on V_CASHSNAPSHOT  to RPBN001;
grant SELECT                                                                 on V_CASHSNAPSHOT  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CASHSNAPSHOT  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CASHSNAPSHOT.sql =========*** End ***
PROMPT ===================================================================================== 
