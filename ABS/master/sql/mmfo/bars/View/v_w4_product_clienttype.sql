

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT_CLIENTTYPE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_PRODUCT_CLIENTTYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_PRODUCT_CLIENTTYPE ("CODE", "NAME", "GRP_CODE", "CLIENT_TYPE") AS 
  select p.code, p.name, g.code, g.client_type
  from w4_product p, v_w4_productgrp_clienttype g
 where p.grp_code = g.code
   and ( -- чк
         g.client_type = 2 and p.nbs not like '3%'
         -- тк
      or g.client_type = 1 and g.code <> 'CORPORATE'
         -- нас
      or g.client_type = 1 and g.code = 'CORPORATE' and p.nbs like '3%' )
   and nvl(p.date_open,bankdate) <= bankdate
   and nvl(p.date_close,bankdate+1) > bankdate;

PROMPT *** Create  grants  V_W4_PRODUCT_CLIENTTYPE ***
grant SELECT                                                                 on V_W4_PRODUCT_CLIENTTYPE to BARSREADER_ROLE;
grant SELECT                                                                 on V_W4_PRODUCT_CLIENTTYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_PRODUCT_CLIENTTYPE to OW;
grant SELECT                                                                 on V_W4_PRODUCT_CLIENTTYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT_CLIENTTYPE.sql =========**
PROMPT ===================================================================================== 
