

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_MVPS_PAYDOCS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_MVPS_PAYDOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_MVPS_PAYDOCS ("FDAT", "REF", "INFREF", "BANK_NAME", "CURRENCY", "AMOUNT") AS 
  select i.fdat, i.ref, i.infref, b.nb bank_name, t.name || ' (' || t.lcv || ')' currency, o.s amount
  from sw_mvps_infdocs i, oper o, banks b, tabval t
 where i.infref = o.ref
   and o.mfob   = b.mfo
   and o.kv     = t.kv
 ;

PROMPT *** Create  grants  V_SW_MVPS_PAYDOCS ***
grant SELECT                                                                 on V_SW_MVPS_PAYDOCS to BARS013;
grant SELECT                                                                 on V_SW_MVPS_PAYDOCS to BARSREADER_ROLE;
grant SELECT                                                                 on V_SW_MVPS_PAYDOCS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW_MVPS_PAYDOCS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_MVPS_PAYDOCS.sql =========*** End 
PROMPT ===================================================================================== 
