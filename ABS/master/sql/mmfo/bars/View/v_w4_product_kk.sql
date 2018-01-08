

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT_KK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_PRODUCT_KK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_PRODUCT_KK ("CODE", "NAME", "GRP_CODE", "CLIENT_TYPE") AS 
  select p.code, p.name, g.code, g.client_type
  from w4_product p, v_w4_productgrp_kk g
 where p.grp_code = g.code
   and exists ( select 1 from v_w4_card_kk where product_code = p.code )
   and nvl(p.date_open,bankdate) <= bankdate
   and nvl(p.date_close,bankdate+1) > bankdate;

PROMPT *** Create  grants  V_W4_PRODUCT_KK ***
grant SELECT                                                                 on V_W4_PRODUCT_KK to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT_KK.sql =========*** End **
PROMPT ===================================================================================== 
