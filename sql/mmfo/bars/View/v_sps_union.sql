

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SPS_UNION.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SPS_UNION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SPS_UNION ("UNION_ID", "UNION_NAME", "SPS") AS 
  select union_id, union_name, sps
  from sps_union
 where union_id not in (1, 2)
;

PROMPT *** Create  grants  V_SPS_UNION ***
grant SELECT                                                                 on V_SPS_UNION     to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SPS_UNION     to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SPS_UNION     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SPS_UNION.sql =========*** End *** ==
PROMPT ===================================================================================== 
