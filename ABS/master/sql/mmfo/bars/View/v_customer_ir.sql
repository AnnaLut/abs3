

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_IR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_IR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_IR ("RNK", "NMK", "OKPO", "CUSTTYPE", "PRINSIDER", "DATE_OFF", "DATE_ON", "PASSP", "SER", "NUMDOC", "INSFORM") AS 
  select c.rnk      ,
       c.nmk      ,
       c.okpo     ,
       c.custtype ,
       c.prinsider,
       c.date_off ,
       c.date_on  ,
       p.passp    ,
       P.SER      ,
       P.NUMDOC   ,
       W.VALUE insform
from   customer  c,
       person    p,
       customerw w
where  p.rnk(+)=c.rnk and
       W.RNK(+)=c.rnk and
       w.tag(+)='INSFO';

PROMPT *** Create  grants  V_CUSTOMER_IR ***
grant SELECT                                                                 on V_CUSTOMER_IR   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUSTOMER_IR   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_IR   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_IR.sql =========*** End *** 
PROMPT ===================================================================================== 
