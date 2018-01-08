

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_SOB_TXT_U.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_SOB_TXT_U ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_SOB_TXT_U ("TXT") AS 
  SELECT TXT
     FROM bars.CC_SOB_TXT;

PROMPT *** Create  grants  CC_SOB_TXT_U ***
grant SELECT                                                                 on CC_SOB_TXT_U    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SOB_TXT_U    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_SOB_TXT_U.sql =========*** End *** =
PROMPT ===================================================================================== 
