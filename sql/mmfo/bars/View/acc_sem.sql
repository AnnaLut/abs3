

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACC_SEM.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view ACC_SEM ***

  CREATE OR REPLACE FORCE VIEW BARS.ACC_SEM ("ACC", "NMS") AS 
  select acc, 
substr(nls||'          ',1,14)||'/'||substr(1000+kv,2,3)||' '||nms
from accounts;

PROMPT *** Create  grants  ACC_SEM ***
grant SELECT                                                                 on ACC_SEM         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_SEM         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACC_SEM.sql =========*** End *** ======
PROMPT ===================================================================================== 
