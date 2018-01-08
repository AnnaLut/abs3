

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_CRV_REQUEST.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_CRV_REQUEST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_CRV_REQUEST ("ID", "NAME") AS 
  select id, name
  from ow_crv_request
 where id > 2;

PROMPT *** Create  grants  V_OW_CRV_REQUEST ***
grant SELECT                                                                 on V_OW_CRV_REQUEST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_CRV_REQUEST to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_CRV_REQUEST.sql =========*** End *
PROMPT ===================================================================================== 
