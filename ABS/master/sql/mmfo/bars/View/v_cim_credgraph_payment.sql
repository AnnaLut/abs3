

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_CREDGRAPH_PAYMENT.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_CREDGRAPH_PAYMENT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_CREDGRAPH_PAYMENT ("CONTR_ID", "ROW_ID", "DAT", "S", "PAY_FLAG_ID", "PAY_FLAG") AS 
  SELECT p.contr_id, rowidtochar(rowid) as row_id, p.dat, round(p.s/100,2),
          p.pay_flag, (select name from cim_payflag where id=p.pay_flag)
     from cim_credgraph_payment p
     order by p.dat;

PROMPT *** Create  grants  V_CIM_CREDGRAPH_PAYMENT ***
grant SELECT                                                                 on V_CIM_CREDGRAPH_PAYMENT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_CREDGRAPH_PAYMENT.sql =========**
PROMPT ===================================================================================== 
