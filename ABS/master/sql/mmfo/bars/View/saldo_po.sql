

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALDO_PO.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view SALDO_PO ***

  CREATE OR REPLACE FORCE VIEW BARS.SALDO_PO ("NLS", "KV", "ACC", "PAP", "DAZS", "NBS", "P") AS 
  SELECT nls,kv,acc,PAP,dazs,nbs,DECODE(PAP,2,1,0) P
FROM saldok
UNION
SELECT nls,kv,acc,PAP,dazs,nbs,DECODE(PAP,2,0,1) P
FROM saldod
 ;

PROMPT *** Create  grants  SALDO_PO ***
grant SELECT                                                                 on SALDO_PO        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALDO_PO        to PYOD001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SALDO_PO        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALDO_PO.sql =========*** End *** =====
PROMPT ===================================================================================== 
