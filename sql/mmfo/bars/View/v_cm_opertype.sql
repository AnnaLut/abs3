

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CM_OPERTYPE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CM_OPERTYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CM_OPERTYPE ("ID", "NAME", "CLIENTTYPE") AS 
  select id, name, clienttype
  from cm_opertype
 where clienttype is null or clienttype > 0;

PROMPT *** Create  grants  V_CM_OPERTYPE ***
grant SELECT                                                                 on V_CM_OPERTYPE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CM_OPERTYPE   to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CM_OPERTYPE.sql =========*** End *** 
PROMPT ===================================================================================== 
