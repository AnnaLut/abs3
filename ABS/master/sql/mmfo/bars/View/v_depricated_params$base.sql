

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_PARAMS$BASE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEPRICATED_PARAMS$BASE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEPRICATED_PARAMS$BASE ("PAR", "VAL", "COMM", "KF") AS 
  select substr(bav.attribute_code,1, 20) par,
       substr(bav.attribute_value,1,250) val,
       substr(a.attribute_desc,1,250) comm,
       substr(bars.branch_utl.get_kf_from_branch_code(b.branch), 1, 6) kf
from   branch_attribute_value bav,
       branch_attribute a,
       branch b
where a.attribute_code = bav.attribute_code
  and a.attribute_code not in ('BANKDATE', 'RRPDAY')
  and bav.branch_code = b.branch
  and length(b.branch) = 8
union all
select substr(bav.attribute_code,1, 20) par,
       substr(bav.attribute_value,1,250) val,
       substr(a.attribute_desc,1,250) comm,
       r.kf
from   branch_attribute_value bav,
       branch_attribute a,
       regions r
where a.attribute_code = bav.attribute_code
  and a.attribute_code in ('BANKDATE', 'RRPDAY')
  and bav.branch_code = '/';

PROMPT *** Create  grants  V_DEPRICATED_PARAMS$BASE ***
grant FLASHBACK,REFERENCES,SELECT                                            on V_DEPRICATED_PARAMS$BASE to BARSAQ with grant option;
grant SELECT                                                                 on V_DEPRICATED_PARAMS$BASE to BARSREADER_ROLE;
grant SELECT                                                                 on V_DEPRICATED_PARAMS$BASE to BARSUPL;
grant SELECT                                                                 on V_DEPRICATED_PARAMS$BASE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DEPRICATED_PARAMS$BASE to START1;
grant SELECT                                                                 on V_DEPRICATED_PARAMS$BASE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEPRICATED_PARAMS$BASE.sql =========*
PROMPT ===================================================================================== 
