

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_VALUABLES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_VALUABLES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_VALUABLES ("NBS", "OB22", "NAME") AS 
  select r020, ob22, txt
 from sb_ob22
 where r020 in ('9819', '9812', '9810', '9820', '9821')  and d_close is null
 ;

PROMPT *** Create  grants  V_VALUABLES ***
grant SELECT                                                                 on V_VALUABLES     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_VALUABLES     to PYOD001;
grant SELECT                                                                 on V_VALUABLES     to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_VALUABLES     to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_VALUABLES     to WR_DOC_INPUT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_VALUABLES.sql =========*** End *** ==
PROMPT ===================================================================================== 
