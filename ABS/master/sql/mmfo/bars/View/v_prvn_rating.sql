

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRVN_RATING.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRVN_RATING ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRVN_RATING ("NUM", "CODE", "ORD") AS 
  select rownum as num, r.code, r.ord
    from cck_rating r
   order by ord;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRVN_RATING.sql =========*** End *** 
PROMPT ===================================================================================== 
