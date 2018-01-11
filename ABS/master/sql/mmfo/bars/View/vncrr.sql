

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VNCRR.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view VNCRR ***

  CREATE OR REPLACE FORCE VIEW BARS.VNCRR ("CODE", "ORD", "MIN", "MAX", "I_MIN", "I_MAX") AS 
  select "CODE","ORD","MIN","MAX","I_MIN","I_MAX" from CCK_RATING;

PROMPT *** Create  grants  VNCRR ***
grant SELECT                                                                 on VNCRR           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VNCRR           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VNCRR.sql =========*** End *** ========
PROMPT ===================================================================================== 
