

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRVN_RATING.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRVN_RATING ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRVN_RATING ("NUM", "CODE", "ORD") AS 
  select rownum as num, r.code, r.ord
    from cck_rating r
   order by ord;

PROMPT *** Create  grants  V_PRVN_RATING ***
grant SELECT                                                                 on V_PRVN_RATING   to BARSREADER_ROLE;
grant SELECT                                                                 on V_PRVN_RATING   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRVN_RATING.sql =========*** End *** 
PROMPT ===================================================================================== 
