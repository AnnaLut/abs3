

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACC.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.ACC ("ACC", "NLS", "KV", "PAP") AS 
  select acc,nls,kv,pap from accounts;

PROMPT *** Create  grants  ACC ***
grant SELECT                                                                 on ACC             to BARSREADER_ROLE;
grant SELECT                                                                 on ACC             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC             to START1;
grant SELECT                                                                 on ACC             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACC.sql =========*** End *** ==========
PROMPT ===================================================================================== 
