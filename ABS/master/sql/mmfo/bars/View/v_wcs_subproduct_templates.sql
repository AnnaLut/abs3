

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_TEMPLATES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_TEMPLATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_TEMPLATES ("SUBPRODUCT_ID", "PRINT_STATE_ID", "PRINT_STATE_NAME", "TEMPLATE_ID", "TEMPLATE_NAME", "IS_SCAN_REQUIRED") AS 
  select st.subproduct_id,
       st.print_state_id,
       ps.name           as print_state_name,
       st.template_id,
       dt.name           as template_name,
       st.is_scan_required
  from wcs_subproduct_templates st, wcs_print_states ps, v_doc_templates dt
 where st.print_state_id = ps.id
   and st.template_id = dt.id
 order by st.subproduct_id, st.print_state_id, st.template_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_TEMPLATES ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_TEMPLATES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_TEMPLATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_TEMPLATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_TEMPLATES.sql ========
PROMPT ===================================================================================== 
