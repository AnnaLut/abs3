

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUSTT.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view CUSTT ***

  CREATE OR REPLACE FORCE VIEW BARS.CUSTT ("CUSTTYPE", "NAME") AS 
  select "CUSTTYPE","NAME" from custtype union all (select 4, 'тно' from dual);

PROMPT *** Create  grants  CUSTT ***
grant SELECT                                                                 on CUSTT           to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTT           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTT           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUSTT.sql =========*** End *** ========
PROMPT ===================================================================================== 
