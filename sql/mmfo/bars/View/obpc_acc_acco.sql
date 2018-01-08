

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OBPC_ACC_ACCO.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view OBPC_ACC_ACCO ***

  CREATE OR REPLACE FORCE VIEW BARS.OBPC_ACC_ACCO ("ACC", "NBS", "NLS", "KV", "NMS", "TIP", "DAOS", "ISP", "PAP", "LIM") AS 
  SELECT ACC, NBS, NLS, KV, NLS || ' - ' || NMS NMS, TIP, DAOS, ISP, PAP, LIM
      FROM ACCOUNTS WHERE TIP = 'SS ' AND DAZS IS NULL;

PROMPT *** Create  grants  OBPC_ACC_ACCO ***
grant SELECT                                                                 on OBPC_ACC_ACCO   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_ACC_ACCO   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OBPC_ACC_ACCO.sql =========*** End *** 
PROMPT ===================================================================================== 
