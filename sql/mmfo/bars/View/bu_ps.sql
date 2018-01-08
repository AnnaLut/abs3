

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BU_PS.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view BU_PS ***

  CREATE OR REPLACE FORCE VIEW BARS.BU_PS ("NBS", "NAME") AS 
  select nbs, name from ps where nbs like '6%' or nbs like '7%'
union all select '_08 ', 'Процентнi, за операцiями з фiлiями банку' from dual
union all select '_18 ', 'Комiсiйнi, за операцiями з фiлiями банку' from dual
union all select '_38 ', 'Iншi операцiйнi, за операцiями з фiлiями банку' from dual
 ;

PROMPT *** Create  grants  BU_PS ***
grant SELECT                                                                 on BU_PS           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BU_PS           to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BU_PS.sql =========*** End *** ========
PROMPT ===================================================================================== 
