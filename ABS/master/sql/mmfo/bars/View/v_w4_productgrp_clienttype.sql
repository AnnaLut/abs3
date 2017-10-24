

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCTGRP_CLIENTTYPE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_PRODUCTGRP_CLIENTTYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_PRODUCTGRP_CLIENTTYPE ("CODE", "NAME", "SCHEME_ID", "CLIENT_TYPE") AS 
  select code, name, scheme_id, 1
  from w4_product_groups
 where client_type = 1
   and code not in ('INSTANT', 'LOCAL')
   and nvl(date_open,bankdate) <= bankdate
   and nvl(date_close,bankdate+1) > bankdate
union all
select code, name, scheme_id, 1
  from w4_product_groups
 where code = 'CORPORATE'
   and nvl(date_open,bankdate) <= bankdate
   and nvl(date_close,bankdate+1) > bankdate
union all
select code, name, scheme_id, 2
  from w4_product_groups
 where client_type = 2
   and code not in ('INSTANT', 'LOCAL')
   and nvl(date_open,bankdate) <= bankdate
   and nvl(date_close,bankdate+1) > bankdate;

PROMPT *** Create  grants  V_W4_PRODUCTGRP_CLIENTTYPE ***
grant SELECT                                                                 on V_W4_PRODUCTGRP_CLIENTTYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_PRODUCTGRP_CLIENTTYPE to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCTGRP_CLIENTTYPE.sql ========
PROMPT ===================================================================================== 
