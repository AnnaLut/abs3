

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SURVEYS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SURVEYS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SURVEYS ("SURVEY_ID", "SURVEY_NAME", "GRP_CNT") AS 
  select s.id as survey_id,
       s.name as survey_name,
       (select count(*)
          from wcs_survey_groups sg
         where sg.survey_id = s.id) as grp_cnt
  from wcs_surveys s
 order by s.id;

PROMPT *** Create  grants  V_WCS_SURVEYS ***
grant SELECT                                                                 on V_WCS_SURVEYS   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SURVEYS.sql =========*** End *** 
PROMPT ===================================================================================== 
