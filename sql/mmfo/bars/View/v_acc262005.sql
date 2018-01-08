

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACC262005.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACC262005 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACC262005 ("NLS", "KV", "DAT") AS 
  SELECT a.NLS,a.KV, b.DAPP_REAL
  FROM   Accounts a, ACC262005 b
  WHERE  a.ACC=b.ACC;

PROMPT *** Create  grants  V_ACC262005 ***
grant SELECT                                                                 on V_ACC262005     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACC262005     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACC262005.sql =========*** End *** ==
PROMPT ===================================================================================== 
