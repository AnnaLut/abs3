

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_SCANS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_SCANS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_SCANS ("SCAN_ID", "NAME") AS 
  select s.id as scan_id,
       s.name
  from ins_scans s
 order by s.id;

PROMPT *** Create  grants  V_INS_SCANS ***
grant SELECT                                                                 on V_INS_SCANS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_SCANS.sql =========*** End *** ==
PROMPT ===================================================================================== 
