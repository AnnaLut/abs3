

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VNCRP.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view VNCRP ***

  CREATE OR REPLACE FORCE VIEW BARS.VNCRP ("CODE", "ORD", "MIN", "MAX", "I_MIN", "I_MAX") AS 
  select "CODE","ORD","MIN","MAX","I_MIN","I_MAX" from CCK_RATING;

PROMPT *** Create  grants  VNCRP ***
grant SELECT                                                                 on VNCRP           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VNCRP           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VNCRP.sql =========*** End *** ========
PROMPT ===================================================================================== 