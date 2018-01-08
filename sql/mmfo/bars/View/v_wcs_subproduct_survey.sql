

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_SURVEY.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_SURVEY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_SURVEY ("SUBPRODUCT_ID", "SURVEY_ID", "SURVEY_NAME", "GRP_CNT") AS 
  select ss.subproduct_id, ss.survey_id, s.survey_name, s.grp_cnt
  from wcs_subproduct_survey ss, v_wcs_surveys s
 where ss.survey_id = s.survey_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_SURVEY ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_SURVEY to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_SURVEY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_SURVEY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_SURVEY.sql =========**
PROMPT ===================================================================================== 
