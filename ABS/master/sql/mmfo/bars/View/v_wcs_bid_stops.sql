

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_STOPS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_STOPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_STOPS ("BID_ID", "STOP_ID", "STOP_NAME", "TYPE_ID", "TYPE_NAME", "FIRED") AS 
  select b.id as bid_id,
       ss.stop_id,
       s.name as stop_name,
       s.type_id,
       st.name as type_name,
       to_number(wcs_utl.get_answ(b.id, s.result_qid)) as fired
  from wcs_bids b, wcs_subproduct_stops ss, wcs_stops s, wcs_stop_types st
 where b.subproduct_id = ss.subproduct_id
   and ss.stop_id = s.id
   and s.type_id = st.id
 order by b.id, s.type_id, s.id;

PROMPT *** Create  grants  V_WCS_BID_STOPS ***
grant SELECT                                                                 on V_WCS_BID_STOPS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_STOPS.sql =========*** End **
PROMPT ===================================================================================== 
