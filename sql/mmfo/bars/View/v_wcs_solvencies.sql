

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SOLVENCIES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SOLVENCIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SOLVENCIES ("SOLV_ID", "SOLV_NAME", "QUEST_CNT") AS 
  select s.id as solv_id,
       s.name as solv_name,
       (select count(*)
          from wcs_solvency_questions sq
         where sq.solvency_id = s.id) as quest_cnt
  from wcs_solvencies s
 order by s.id;

PROMPT *** Create  grants  V_WCS_SOLVENCIES ***
grant SELECT                                                                 on V_WCS_SOLVENCIES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SOLVENCIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SOLVENCIES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SOLVENCIES.sql =========*** End *
PROMPT ===================================================================================== 
