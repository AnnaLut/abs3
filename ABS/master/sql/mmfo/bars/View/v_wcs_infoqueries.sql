

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_INFOQUERIES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_INFOQUERIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_INFOQUERIES ("IQUERY_ID", "IQUERY_NAME", "TYPE_ID", "TYPE_NAME", "PLSQL") AS 
  select i.id      as iquery_id,
       i.name    as iquery_name,
       i.type_id,
       it.name   as type_name,
       i.plsql
  from wcs_infoqueries i, wcs_infoquery_types it
 where i.type_id = it.id
 order by i.id;

PROMPT *** Create  grants  V_WCS_INFOQUERIES ***
grant SELECT                                                                 on V_WCS_INFOQUERIES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_INFOQUERIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_INFOQUERIES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_INFOQUERIES.sql =========*** End 
PROMPT ===================================================================================== 
