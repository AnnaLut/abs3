

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_PARAMS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEPRICATED_PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEPRICATED_PARAMS ("PAR", "VAL", "COMM") AS 
  select v.attribute_code par,
       substr(min(v.attribute_value) keep (dense_rank last order by v.branch_code desc), 1, 250) val,
       substr((select a.attribute_desc
               from   branch_attribute a
               where  a.attribute_code = v.attribute_code), 1, 250) comm
from   branch_attribute_value v
where  v.branch_code in ('/', '/' || sys_context('bars_context', 'user_mfo') || '/')
group by v.attribute_code;

PROMPT *** Create  grants  V_DEPRICATED_PARAMS ***
grant FLASHBACK,REFERENCES,SELECT                                            on V_DEPRICATED_PARAMS to BARSAQ with grant option;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to BARSUPL;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to START1;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to SWTOSS;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to TOSS;
grant SELECT                                                                 on V_DEPRICATED_PARAMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_PARAMS.sql =========*** En
PROMPT ===================================================================================== 
