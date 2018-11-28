
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/view/v_customer.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BILLS.V_CUSTOMER ("RNK", "NAME", "OKPO", "ACCOUNT_NO") AS 
  select rnk, nmk name, okpo, (select nls from bars.accounts where rnk = c.rnk and nbs = 2620 and dazs is null and kv = 980) account_no
from bars.customer c
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/view/v_customer.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 