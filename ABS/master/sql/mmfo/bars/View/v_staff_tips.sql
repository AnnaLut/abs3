

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_TIPS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_TIPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_TIPS ("ID", "FIO", "LOGNAME", "TABN", "BRANCH", "TIP", "NAME") AS 
  SELECT sb.id,
          sb.fio,
          sb.logname,
          sb.tabn,
          sb.branch,
          st.id tip,
          st.name
     FROM staff$base sb, staff_tips st
    WHERE sb.tip = st.id;

PROMPT *** Create  grants  V_STAFF_TIPS ***
grant SELECT                                                                 on V_STAFF_TIPS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STAFF_TIPS    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_TIPS.sql =========*** End *** =
PROMPT ===================================================================================== 
