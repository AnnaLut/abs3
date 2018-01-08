

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAL23.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAL23 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAL23 ("ND", "ZAL") AS 
  select nd, sum(s)/100 ZAL from tmp_rez_obesp23  where dat = TO_DATE(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy')
group by nd ;

PROMPT *** Create  grants  V_ZAL23 ***
grant SELECT                                                                 on V_ZAL23         to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAL23         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAL23.sql =========*** End *** ======
PROMPT ===================================================================================== 
