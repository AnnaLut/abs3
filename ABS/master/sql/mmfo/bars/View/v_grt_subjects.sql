

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRT_SUBJECTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRT_SUBJECTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRT_SUBJECTS ("SUBJ_ID", "SUBJ_NAME", "TYPE_ID") AS 
  select
  s.subj_id,
  s.subj_name,
  s.type_id
from
  grt_subjects s;

PROMPT *** Create  grants  V_GRT_SUBJECTS ***
grant SELECT                                                                 on V_GRT_SUBJECTS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRT_SUBJECTS.sql =========*** End ***
PROMPT ===================================================================================== 
