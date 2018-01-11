

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EDEAL_ND_ACC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EDEAL_ND_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EDEAL_ND_ACC ("ND", "NAME", "ACC") AS 
  (select nd, 'ACC26' as name, acc26 as acc from e_deal$base
    union
    select nd, 'ACC36' as name, acc36 as acc from e_deal$base
    union
    select nd, 'ACCD' as name, accd as acc from e_deal$base
    union
    select nd, 'ACCP' as name, accp as acc from e_deal$base);

PROMPT *** Create  grants  V_EDEAL_ND_ACC ***
grant SELECT                                                                 on V_EDEAL_ND_ACC  to BARSREADER_ROLE;
grant SELECT                                                                 on V_EDEAL_ND_ACC  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_EDEAL_ND_ACC  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EDEAL_ND_ACC.sql =========*** End ***
PROMPT ===================================================================================== 
