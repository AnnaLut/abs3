

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_CUSTOMERS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_CUSTOMERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_CUSTOMERS ("RNK", "CUSTTYPE", "NMK", "OKPO", "DOC_SER", "DOC_NUM", "DOC_ISSUER", "DOC_DATE", "DATE_OFF") AS 
  select c.rnk,
       c.custtype,
       c.nmk,
       c.okpo,
       p.ser      as doc_ser,
       p.numdoc   as doc_num,
       p.organ    as doc_issuer,
       p.pdate    as doc_date,
       c.date_off
  from customer c,
       person p
 where c.rnk = p.rnk(+);

PROMPT *** Create  grants  V_INS_CUSTOMERS ***
grant SELECT                                                                 on V_INS_CUSTOMERS to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_CUSTOMERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_CUSTOMERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_CUSTOMERS.sql =========*** End **
PROMPT ===================================================================================== 
