

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_USERKL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_USERKL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_USERKL ("REF") AS 
  select ref
from oper
where userid=user_id
   or (tt like 'KL%' and substr(chk,3,4)=LPAD(chk.TO_HEX(user_id),4,'0'));

PROMPT *** Create  grants  V_OPER_USERKL ***
grant SELECT                                                                 on V_OPER_USERKL   to BARSREADER_ROLE;
grant SELECT                                                                 on V_OPER_USERKL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPER_USERKL   to START1;
grant SELECT                                                                 on V_OPER_USERKL   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OPER_USERKL   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_USERKL.sql =========*** End *** 
PROMPT ===================================================================================== 
