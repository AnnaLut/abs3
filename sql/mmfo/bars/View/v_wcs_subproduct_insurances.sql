

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_INSURANCES.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_INSURANCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_INSURANCES ("SUBPRODUCT_ID", "INSURANCE_ID", "INSURANCE_NAME", "IS_REQUIRED", "ORD", "WS_ID") AS 
  select si.subproduct_id,
       si.insurance_id,
       i.name as insurance_name,
       si.is_required,
       si.ord,
       si.ws_id
  from wcs_subproduct_insurances si, wcs_insurances i
 where si.insurance_id = i.id
 order by si.subproduct_id, si.ord;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_INSURANCES ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_INSURANCES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_INSURANCES.sql =======
PROMPT ===================================================================================== 
