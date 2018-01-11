

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TECH_ACC_CREDIT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TECH_ACC_CREDIT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TECH_ACC_CREDIT ("REF", "REFL", "ACC", "NLS", "KV", "SUM", "SUM100", "LCV", "DAT", "TT", "NAZN", "BRANCH") AS 
  select p.ref, p.refl, to_char(o.acc), a.nls, a.kv,
       to_char(o.s/100, '999999999990.99'), o.s, t.lcv,
       o.fdat, o.tt, p.nazn, a.branch
  from opldok o, oper p, tabval t, tts s, accounts a
 where a.acc = o.acc
   and o.fdat >= add_months(bankdate, - 1)
   and o.fdat <= bankdate
   and o.dk = 1
   and o.sos = 5
   and o.ref = p.ref
   and a.kv = t.kv
   and s.tt = o.tt
   and s.sk is null
   and a.tip = 'TCH'
   and s.tt not in (select tt from op_rules where tag = 'DPTOP')
 order by o.fdat, o.s desc
 ;

PROMPT *** Create  grants  V_TECH_ACC_CREDIT ***
grant SELECT                                                                 on V_TECH_ACC_CREDIT to BARSREADER_ROLE;
grant SELECT                                                                 on V_TECH_ACC_CREDIT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TECH_ACC_CREDIT to DPT_ROLE;
grant SELECT                                                                 on V_TECH_ACC_CREDIT to RPBN001;
grant SELECT                                                                 on V_TECH_ACC_CREDIT to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TECH_ACC_CREDIT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TECH_ACC_CREDIT.sql =========*** End 
PROMPT ===================================================================================== 
