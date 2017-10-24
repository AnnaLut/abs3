

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_BANK_VIPISKA.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_BANK_VIPISKA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_BANK_VIPISKA ("VALUE_DATE", "VALUE_DATE_TXT", "RECEIVER_NAME", "RECEIVER_EDRPOU", "RECEIVER_MFO", "RECEIVER_ACCOUNT", "PAYER_MFO", "BANK_NAME", "PAYER_ACCOUNT", "PAYMENT_AMOUNT", "DEBT_AMOUNT", "FEE_AMOUNT", "ALL_AMOUNT", "AMOUNT", "PAYED_DATE", "PRODUCT_NAME", "PAYER_ADDR_FACT", "PAYER_TEL", "CUSTOMER_ACCOUNT", "PAYMENT_ID", "ORDER_ID", "RNK", "TRANS_ACC_2924") AS 
  select
  /*ƒл€ отчета Ѕанк. выписка по регул€рным платежам*/
          to_char(sp.value_date,'dd/mm/yyyy') as value_date,
          '«а '|| to_char (sp.value_date,'month','nls_date_language = UKRAINIAN')|| ' м≥с€ць '|| to_char (sp.value_date, 'yyyy') as value_date_txt,
          sp.receiver_name,
          sp.receiver_edrpou,
          sp.receiver_mfo,
          sp.receiver_account,
          sp.payer_mfo,
          (select val
             from params$base
            where par = 'NAME'
              and kf =  sp.payer_mfo) as bank_name,
          sp.payer_account,
          sp.payment_amount,
          nvl(sp.debt_amount,sp.payment_amount) debt_amount,
          sp.fee_amount,
          to_char(nvl(sp.payment_amount,0),'FM9999999990.0099')||' '||val.LCV as all_amount,
          to_char(greatest (nvl(sp.debt_amount-sp.payment_amount,0),0 ), 'FM9999999990.0099')||' '||val.LCV as amount,
          (select to_char (max(spt.sys_time), 'dd/mm/yyyy HH24:MI:DD')
             from sto_payment_tracking spt
            where spt.payment_id=sp.payment_id
              and spt.state=5) as payed_date,
          sp.product_name,
          cus.adr as payer_addr_fact,
          (select nvl (teld, telw)
             from person
            where rnk = sp.rnk) as payer_tel,
          sp.customer_account,
          sp.payment_id,
          sp.order_id,
          sp.rnk,
          (select a.nls
             from opldok o,
                  accounts a,
                  sto_payment_document_link sd
            where o.acc=a.acc
              and o.dk = 1
              and o.tt='ST1'
              and substr(a.nls,1,4) = '2924'
              and o.ref = sd.document_id
              and sd.payment_id = sp.payment_id
           ) as trans_acc_2924
      from v_sto_payments sp,
           customer cus,
           tabval$global val
     where sp.rnk=cus.rnk
       and val.kv = sp.payment_currency
       and sp.payment_state_id = 5;

PROMPT *** Create  grants  V_STO_BANK_VIPISKA ***
grant SELECT                                                                 on V_STO_BANK_VIPISKA to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_BANK_VIPISKA.sql =========*** End
PROMPT ===================================================================================== 
