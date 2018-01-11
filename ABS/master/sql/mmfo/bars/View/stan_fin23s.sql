

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STAN_FIN23S.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view STAN_FIN23S ***

  CREATE OR REPLACE FORCE VIEW BARS.STAN_FIN23S ("FIN23", "NAME") AS 
  select 1, 'А=Добрий'        from dual union all 
    select 2, 'Б=Задовiльний'   from dual union all 
    select 3, 'В=НЕзадовiльний' from dual union all 
    select 4, 'Г=Критичний' from dual;

PROMPT *** Create  grants  STAN_FIN23S ***
grant SELECT                                                                 on STAN_FIN23S     to BARSREADER_ROLE;
grant SELECT                                                                 on STAN_FIN23S     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAN_FIN23S     to START1;
grant SELECT                                                                 on STAN_FIN23S     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STAN_FIN23S.sql =========*** End *** ==
PROMPT ===================================================================================== 
