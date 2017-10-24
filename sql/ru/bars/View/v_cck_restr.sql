

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_RESTR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_RESTR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_RESTR ("ND", "FDAT", "VID_RESTR", "TXT", "SUMR", "FDAT_END", "PR_NO") AS 
  select ND, FDAT, VID_RESTR, TXT, SUMR, FDAT_END, PR_NO
from cck_restr
union all
select -acc, FDAT, VID_RESTR, TXT, SUMR, FDAT_END, PR_NO
from cck_restr_acc;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_RESTR.sql =========*** End *** ==
PROMPT ===================================================================================== 
