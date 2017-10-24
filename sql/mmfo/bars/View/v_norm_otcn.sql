

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NORM_OTCN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NORM_OTCN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NORM_OTCN ("PAR", "VAL", "COMM") AS 
  SELECT par, val, comm
     FROM params
    WHERE par LIKE 'NOR%';

PROMPT *** Create  grants  V_NORM_OTCN ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NORM_OTCN     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_NORM_OTCN     to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NORM_OTCN.sql =========*** End *** ==
PROMPT ===================================================================================== 
