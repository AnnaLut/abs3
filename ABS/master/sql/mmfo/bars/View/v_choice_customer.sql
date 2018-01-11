

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CHOICE_CUSTOMER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CHOICE_CUSTOMER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CHOICE_CUSTOMER ("CUSTTYPE", "RNK", "NMK", "OKPO", "REZID", "MFO", "PASSP_SER", "PASSP_NUM", "BDAY", "CLIENT_ID") AS 
  select c.custtype, c.rnk, c.nmk, c.okpo, decode(mod(c.codcagent,2),1,1,2),
       b.mfo, null, null, null, null
  from customer c, custbank b
 where c.custtype = 1 and c.rnk = b.rnk
 union all
select c.custtype, c.rnk, c.nmk, c.okpo, decode(mod(c.codcagent,2),1,1,2),
       null, null, null, null, null
  from customer c
 where c.custtype = 2
 union all
select decode(nvl(trim(c.sed),'00'),'91',10,9), c.rnk, c.nmk, c.okpo, decode(mod(c.codcagent,2),1,1,2),
       null, p.ser, p.numdoc, p.bday, null
  from customer c, person p
 where c.custtype = 3 and c.rnk = p.rnk
;

PROMPT *** Create  grants  V_CHOICE_CUSTOMER ***
grant SELECT                                                                 on V_CHOICE_CUSTOMER to BARSREADER_ROLE;
grant SELECT                                                                 on V_CHOICE_CUSTOMER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CHOICE_CUSTOMER to CUST001;
grant SELECT                                                                 on V_CHOICE_CUSTOMER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CHOICE_CUSTOMER.sql =========*** End 
PROMPT ===================================================================================== 
