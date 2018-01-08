

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_GARANTEE_TEMPLATES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_GARANTEE_TEMPLATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_GARANTEE_TEMPLATES ("GARANTEE_ID", "PRINT_STATE_ID", "PRINT_STATE_NAME", "TEMPLATE_ID", "TEMPLATE_NAME", "IS_SCAN_REQUIRED") AS 
  select gt.garantee_id,
       gt.print_state_id,
       ps.name           as print_state_name,
       gt.template_id,
       dt.name           as template_name,
       gt.is_scan_required
  from wcs_garantee_templates gt, wcs_print_states ps, v_doc_templates dt
 where gt.print_state_id = ps.id
   and gt.template_id = dt.id
 order by gt.garantee_id, gt.print_state_id, gt.template_id;

PROMPT *** Create  grants  V_WCS_GARANTEE_TEMPLATES ***
grant SELECT                                                                 on V_WCS_GARANTEE_TEMPLATES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_GARANTEE_TEMPLATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_GARANTEE_TEMPLATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_GARANTEE_TEMPLATES.sql =========*
PROMPT ===================================================================================== 
