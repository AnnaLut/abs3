

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_INIC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_INIC ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_INIC ("ID", "NAME") AS 
  select 0,'ÊËÈÅÍÒ' from dual where 1>2;

PROMPT *** Create  grants  CC_INIC ***
grant SELECT                                                                 on CC_INIC         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_INIC         to RCC_DEAL;
grant SELECT                                                                 on CC_INIC         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_INIC.sql =========*** End *** ======
PROMPT ===================================================================================== 
