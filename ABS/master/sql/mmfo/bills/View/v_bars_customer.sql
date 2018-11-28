
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/view/v_bars_customer.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BILLS.V_BARS_CUSTOMER AS 
  select
c.kf,
c.rnk,
c.nmk,
c.okpo,
p.bday,
p.pdate,
p.ser,
p.numdoc,
p.organ,
(select nls from bars.accounts where rnk = c.rnk and nbs = 2620 and dazs is null and kv = 980 and rownum = 1) account_no,
c.custtype,
ct.name as custtype_name,
cw.value as phone,
bars.f_get_adr(c.rnk) as adr
from bars.customer c
join bars.custtype ct on c.custtype = ct.custtype
left join bars.person p on c.rnk = p.rnk
left join bars.customerw cw on cw.rnk = c.rnk and cw.tag = 'MPNO'
where c.custtype in (2, 3)
and c.date_off is null;
 show err;
 
PROMPT *** Create  grants  V_BARS_CUSTOMER ***
grant SELECT                                                                 on V_BARS_CUSTOMER to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/view/v_bars_customer.sql =========*** End *
 PROMPT ===================================================================================== 
 