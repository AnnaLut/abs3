

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCOKPO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCOKPO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCOKPO ("ACC", "NLS", "KV", "RNK", "OKPO") AS 
  select a.ACC,a.NLS,a.KV,a.RNK,c.OKPO
 from   Accounts a, Customer c
 where  a.rnk=c.rnk;

PROMPT *** Create  grants  V_ACCOKPO ***
grant SELECT                                                                 on V_ACCOKPO       to BARSREADER_ROLE;
grant SELECT                                                                 on V_ACCOKPO       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCOKPO       to START1;
grant SELECT                                                                 on V_ACCOKPO       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCOKPO.sql =========*** End *** ====
PROMPT ===================================================================================== 
