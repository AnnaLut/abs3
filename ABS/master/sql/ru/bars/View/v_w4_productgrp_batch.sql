create or replace force view v_w4_productgrp_batch as
select g.code, g.name, g.client_type
  from w4_product_groups g
 where g.code in ('PENSION', 'SALARY', 'SOCIAL', 'STANDARD', 'ECONOM', 'PREMIUM', 'SHIDNIY' )
   and nvl(g.date_open,bankdate) <= bankdate
   and nvl(g.date_close,bankdate+1) > bankdate;
grant select on V_W4_PRODUCTGRP_BATCH to BARS_ACCESS_DEFROLE;


