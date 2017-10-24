

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_COUNT_ERRORS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_COUNT_ERRORS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_COUNT_ERRORS ("OBJECT_NAME", "COUNT_ERR") AS 
  select object_name, f_wcs_count_err(object_name) as count_err
from all_objects where object_name like 'ERR$_WCS%';

PROMPT *** Create  grants  V_WCS_COUNT_ERRORS ***
grant SELECT                                                                 on V_WCS_COUNT_ERRORS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_COUNT_ERRORS.sql =========*** End
PROMPT ===================================================================================== 
