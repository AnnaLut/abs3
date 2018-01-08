

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_RISK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_RISK ***

create or replace view v_cust_risk as
select c.rnk RNK, 
       c.okpo OKPO, 
       c.nmk NMK, 
       c.custtype CUSTTYPE, 
       f.id RISK_ID, 
       f.name RISK_NAME, 
       r.dat_begin DAT_BEGIN, 
       r.dat_end DAT_END, 
       s.id STAFF_ID, 
       s.fio STAFF_FIO
from customer_risk r, fm_risk_criteria f, customer c, staff s 
where r.rnk = c.rnk 
   and r.risk_id = f.id
   and r.user_id = s.id
   order by r.rnk, r.risk_id;


PROMPT *** Create  grants  V_CUST_RISK ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CUST_RISK     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_RISK     to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CUST_RISK     to FINMON01;
grant FLASHBACK,SELECT                                                       on V_CUST_RISK     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_RISK.sql =========*** End *** ==
PROMPT ===================================================================================== 
