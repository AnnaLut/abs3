

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_PARAMS$GLOBAL.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEPRICATED_PARAMS$GLOBAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEPRICATED_PARAMS$GLOBAL ("PAR", "VAL", "COMM", "SRV_FLAG") AS 
  select substr(bav.attribute_code, 1, 250) par,
       substr(bav.attribute_value, 1, 250) val,
       substr(a.attribute_desc, 1, 250) comm,
       0 srv_flag
from   branch_attribute_value bav,
       branch_attribute a,
       branch b
where a.attribute_code = bav.attribute_code
  and bav.branch_code =  b.branch
  and length(b.branch)  = 1;

PROMPT *** Create  grants  V_DEPRICATED_PARAMS$GLOBAL ***
grant SELECT                                                                 on V_DEPRICATED_PARAMS$GLOBAL to BARSUPL;
grant SELECT                                                                 on V_DEPRICATED_PARAMS$GLOBAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DEPRICATED_PARAMS$GLOBAL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_PARAMS$GLOBAL.sql ========
PROMPT ===================================================================================== 
