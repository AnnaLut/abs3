

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_STOPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_STOPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_STOPS ("STOP_ID", "STOP_NAME", "TYPE_ID", "TYPE_NAME", "RESULT_QID", "PLSQL") AS 
  select s.id         as stop_id,
       s.name       as stop_name,
       s.type_id,
       st.name      as type_name,
       s.result_qid,
       s.plsql
  from wcs_stops s, wcs_stop_types st
 where s.type_id = st.id
 order by s.type_id, s.id;

PROMPT *** Create  grants  V_WCS_STOPS ***
grant SELECT                                                                 on V_WCS_STOPS     to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_STOPS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_STOPS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_STOPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
