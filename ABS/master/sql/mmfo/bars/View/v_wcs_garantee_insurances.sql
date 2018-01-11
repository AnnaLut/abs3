

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_GARANTEE_INSURANCES.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_GARANTEE_INSURANCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_GARANTEE_INSURANCES ("GARANTEE_ID", "GARANTEE_NAME", "INSURANCE_ID", "INSURANCE_NAME", "IS_REQUIRED", "ORD") AS 
  select gi.garantee_id   as garantee_id,
       g.name           as garantee_name,
       gi.insurance_id,
       i.name as insurance_name,
       gi.is_required,
       gi.ord
  from wcs_garantee_insurances gi, wcs_garantees g, wcs_insurances i
 where gi.garantee_id = g.id
   and gi.insurance_id = i.id
 order by gi.garantee_id, gi.ord;

PROMPT *** Create  grants  V_WCS_GARANTEE_INSURANCES ***
grant SELECT                                                                 on V_WCS_GARANTEE_INSURANCES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_GARANTEE_INSURANCES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_GARANTEE_INSURANCES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_GARANTEE_INSURANCES.sql =========
PROMPT ===================================================================================== 
