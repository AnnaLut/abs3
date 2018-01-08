

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_USER.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_USER ("REF") AS 
  SELECT O.REF
FROM ACCOUNTS A, OPLDOK O, OPER R
WHERE A.ACC=O.ACC AND R.REF=O.REF
  AND ((R.USERID=USER_ID) OR (A.ISP=USER_ID));

PROMPT *** Create  grants  V_OPER_USER ***
grant SELECT                                                                 on V_OPER_USER     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPER_USER     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OPER_USER     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_USER.sql =========*** End *** ==
PROMPT ===================================================================================== 
