create or replace force view v_w4_product_batch
(code, name, grp_code, client_type)
as
select p.code, p.name, g.code, g.client_type
  from w4_product p, v_w4_productgrp_batch g
 where p.grp_code = g.code
   and nvl(p.date_open,bankdate) <= bankdate
   and nvl(p.date_close,bankdate+1) > bankdate;
grant select on V_W4_PRODUCT_BATCH to BARS_ACCESS_DEFROLE;


