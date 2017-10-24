

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCGRP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCGRP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCGRP ("ACC", "GRP") AS 
  select a.acc ACC, b.column_value GRP
from accounts a, table(sec.getAgrp(a.acc)) b
 ;

PROMPT *** Create  grants  V_ACCGRP ***
grant SELECT                                                                 on V_ACCGRP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCGRP        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ACCGRP        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCGRP.sql =========*** End *** =====
PROMPT ===================================================================================== 
