

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CM_ACC_REQUEST.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CM_ACC_REQUEST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CM_ACC_REQUEST ("OPER_TYPE", "OPER_NAME", "DATE_IN", "NLS", "NMK", "RNK", "OKPO", "PRODUCT_CODE", "CARD_TYPE", "OPER_DATE", "ABS_STATUS", "ABS_MSG", "DONEBY") AS 
  select r.oper_type,
       case
         when r.oper_type = 1 then 'Закриття рахунку'
         when r.oper_type = 2 then 'Зміна субпродукту'
         when r.oper_type = 3 then 'Продовження терміну дії'
       end oper_name,
       r.date_in, r.contract_number, c.nmk, c.rnk, c.okpo,
       r.product_code, r.card_type, r.oper_date,
       r.abs_status, r.abs_msg, null
  from cm_acc_request r, accounts a, customer c
 where r.contract_number = a.nls(+)
   and a.rnk = c.rnk(+)
union all
select r.oper_type,
       case
         when r.oper_type = 1 then 'Закриття рахунку'
         when r.oper_type = 2 then 'Зміна субпродукту'
         when r.oper_type = 3 then 'Продовження терміну дії'
       end oper_name,
       r.date_in, r.contract_number, c.nmk, c.rnk, c.okpo,
       r.product_code, r.card_type, r.oper_date,
       r.abs_status,
       case
         when r.abs_status = 1 then r.abs_msg
         when r.abs_status = 2 then 'Оброблено'
         when r.abs_status = 3 then substr('Видалено' || decode(r.abs_msg,null,'',': '||r.abs_msg),1,254)
       end abs_msg, r.doneby
  from cm_acc_request_arc r, accounts a, customer c
 where r.contract_number = a.nls(+)
   and a.rnk = c.rnk(+);

PROMPT *** Create  grants  V_CM_ACC_REQUEST ***
grant DELETE,SELECT                                                          on V_CM_ACC_REQUEST to BARS_ACCESS_DEFROLE;
grant DELETE,SELECT                                                          on V_CM_ACC_REQUEST to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CM_ACC_REQUEST.sql =========*** End *
PROMPT ===================================================================================== 
