

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OBPC_ACC_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view OBPC_ACC_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.OBPC_ACC_ACC ("ACC", "NBS", "NLS", "KV", "NMS", "TIP", "DAOS", "ISP", "PAP", "LIM") AS 
  SELECT ACC, NBS, NLS, KV, NLS || ' - ' || NMS NMS, TIP, DAOS, ISP, PAP, LIM
      FROM ACCOUNTS WHERE TIP LIKE 'PK%' AND DAZS IS NULL;

PROMPT *** Create  grants  OBPC_ACC_ACC ***
grant SELECT                                                                 on OBPC_ACC_ACC    to BARSREADER_ROLE;
grant SELECT                                                                 on OBPC_ACC_ACC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_ACC_ACC    to START1;
grant SELECT                                                                 on OBPC_ACC_ACC    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OBPC_ACC_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
