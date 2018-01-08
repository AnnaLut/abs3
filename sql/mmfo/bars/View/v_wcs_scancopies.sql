

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SCANCOPIES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SCANCOPIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SCANCOPIES ("SCOPY_ID", "SCOPY_NAME", "QUEST_CNT") AS 
  select s.id as scopy_id,
       s.name as scopy_name,
       (select count(*)
          from wcs_scancopy_questions sq
         where sq.scopy_id = s.id) as quest_cnt
  from wcs_scancopies s
 order by s.id;

PROMPT *** Create  grants  V_WCS_SCANCOPIES ***
grant SELECT                                                                 on V_WCS_SCANCOPIES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SCANCOPIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SCANCOPIES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SCANCOPIES.sql =========*** End *
PROMPT ===================================================================================== 
