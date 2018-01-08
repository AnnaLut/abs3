

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NLK_TT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NLK_TT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NLK_TT ("ID", "TT", "NAME") AS 
  select n.id, t.tt, t.name
    from nlk_tt n, tts t
   where n.tt = t.tt;

PROMPT *** Create  grants  V_NLK_TT ***
grant SELECT                                                                 on V_NLK_TT        to BARSREADER_ROLE;
grant SELECT                                                                 on V_NLK_TT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NLK_TT        to START1;
grant SELECT                                                                 on V_NLK_TT        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NLK_TT.sql =========*** End *** =====
PROMPT ===================================================================================== 
