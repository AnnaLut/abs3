

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_STOPS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_STOPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_STOPS ("SUBPRODUCT_ID", "STOP_ID", "STOP_NAME", "ACT_LEVEL", "TYPE_ID", "TYPE_NAME", "RESULT_QID", "PLSQL") AS 
  select ss.subproduct_id,
       ss.stop_id,
       s.stop_name,
       ss.act_level,
       s.type_id,
       s.type_name,
       s.result_qid,
       s.plsql
  from wcs_subproduct_stops ss, v_wcs_stops s
 where ss.stop_id = s.stop_id
 order by ss.subproduct_id, s.type_id, s.stop_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_STOPS ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_STOPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_STOPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_STOPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_STOPS.sql =========***
PROMPT ===================================================================================== 
