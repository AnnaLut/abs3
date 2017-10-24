

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCTGRP_KK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_PRODUCTGRP_KK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_PRODUCTGRP_KK ("CODE", "NAME", "CLIENT_TYPE") AS 
  select g.code, g.name, g.client_type
  from w4_product_groups g
 where g.code in ('PENSION', 'SALARY', 'SOCIAL', 'STANDARD')
   and nvl(g.date_open,bankdate) <= bankdate
   and nvl(g.date_close,bankdate+1) > bankdate;

PROMPT *** Create  grants  V_W4_PRODUCTGRP_KK ***
grant SELECT                                                                 on V_W4_PRODUCTGRP_KK to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCTGRP_KK.sql =========*** End
PROMPT ===================================================================================== 
