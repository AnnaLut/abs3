

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NORM_OTCN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NORM_OTCN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NORM_OTCN ("PAR", "VAL", "COMM") AS 
  SELECT par, val, comm
     FROM params
    WHERE par LIKE 'NOR%';

PROMPT *** Create  grants  V_NORM_OTCN ***
grant SELECT                                                                 on V_NORM_OTCN     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NORM_OTCN     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_NORM_OTCN     to RPBN002;
grant SELECT                                                                 on V_NORM_OTCN     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NORM_OTCN.sql =========*** End *** ==
PROMPT ===================================================================================== 
