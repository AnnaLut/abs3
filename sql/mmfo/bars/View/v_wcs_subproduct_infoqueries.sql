

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_INFOQUERIES.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_INFOQUERIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_INFOQUERIES ("SUBPRODUCT_ID", "IQUERY_ID", "IQUERY_NAME", "TYPE_ID", "TYPE_NAME", "ACT_LEVEL", "SERVICE_ID", "IS_REQUIRED", "ORD", "PLSQL") AS 
  select si.subproduct_id,
       si.iquery_id,
       i.name           as iquery_name,
       i.type_id,
       it.name          as type_name,
       si.act_level,
       si.service_id,
       si.is_required,
       si.ord,
       i.plsql
  from wcs_subproduct_infoqueries si,
       wcs_infoqueries            i,
       wcs_infoquery_types        it
 where si.iquery_id = i.id
   and i.type_id = it.id
 order by si.subproduct_id, si.iquery_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_INFOQUERIES ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_INFOQUERIES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_INFOQUERIES.sql ======
PROMPT ===================================================================================== 
