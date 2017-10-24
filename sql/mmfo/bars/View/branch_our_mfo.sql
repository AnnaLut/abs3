

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BRANCH_OUR_MFO.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view BRANCH_OUR_MFO ***

  CREATE OR REPLACE FORCE VIEW BARS.BRANCH_OUR_MFO ("MFO", "NAME") AS 
  SELECT BRANCH MFO, NAME
     FROM BRANCH
    WHERE LENGTH (BRANCH) = 8 and DATE_CLOSED is NULL;

PROMPT *** Create  grants  BRANCH_OUR_MFO ***
grant SELECT                                                                 on BRANCH_OUR_MFO  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_OUR_MFO  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BRANCH_OUR_MFO.sql =========*** End ***
PROMPT ===================================================================================== 
