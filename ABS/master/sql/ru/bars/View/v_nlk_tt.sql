
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/View/V_NLK_TT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NLK_TT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NLK_TT (ID, TT, NAME) AS 
  select n.id, t.tt, t.name
    from nlk_tt n, tts t
   where n.tt = t.tt;

grant SELECT         on V_NLK_TT         to BARS_ACCESS_DEFROLE;
grant SELECT         on V_NLK_TT         to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/View/V_NLK_TT.sql =========*** End *** =====
PROMPT ===================================================================================== 
