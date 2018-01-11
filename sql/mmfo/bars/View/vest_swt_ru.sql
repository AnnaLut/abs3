

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VEST_SWT_RU.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view VEST_SWT_RU ***

  CREATE OR REPLACE FORCE VIEW BARS.VEST_SWT_RU ("VM", "KOL", "REF", "MFOB", "NLSB", "NAM_B", "KV", "S", "VDAT", "NAME", "TT", "REF_CLI") AS 
  select f.VM, f.KOL, f.REF, o.MFOB, o.NLSB, O.NAM_B, o.KV, o.S/100 S, o.vdat , r.name, o.tt,
  f.REF_CLI
from Test_swt_ru f, oper o, BANKS_RU r
where o.ref = decode ( f.ref_cli, null, f.ref,f.ref_cli) and o.mfob = r.mfo;

PROMPT *** Create  grants  VEST_SWT_RU ***
grant SELECT                                                                 on VEST_SWT_RU     to BARSREADER_ROLE;
grant SELECT                                                                 on VEST_SWT_RU     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VEST_SWT_RU     to START1;
grant SELECT                                                                 on VEST_SWT_RU     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VEST_SWT_RU.sql =========*** End *** ==
PROMPT ===================================================================================== 
