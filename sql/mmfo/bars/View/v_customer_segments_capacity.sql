

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS_CAPACITY.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_SEGMENTS_CAPACITY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_SEGMENTS_CAPACITY ("RNK", "PRODUCT_AMOUNT", "DEPOSIT_AMOUNT", "CREDITS_AMOUNT", "CARDCREDITS_AMOUNT", "GARANT_CREDITS_AMOUNT", "ENERGYCREDITS_AMOUNT", "CARDS_AMOUNT", "ACCOUNTS_AMOUNT", "INDIVIDUAL_SAFES_AMOUNT", "CASHLOANS_AMOUNT", "BPK_CREDITLINE_AMOUNT", "INSURANCE_AVTOCIVILKA_AMOUNT", "INSURANCE_AVTOCIVILKAPLUS_AMNT", "INSURANCE_OBERIG_AMOUNT", "INSURANCE_CASH_AMOUNT","CARD_CREDIT_PRIME","MOBILE_SAVING","OSHAD_ACTIVE") AS 
 select c.rnk     as rnk,
       (T2.NUMBER_VALUE)  as product_amount,
       T3.NUMBER_VALUE  as deposit_amount,
       T4.NUMBER_VALUE  as credits_amount,
       T5.NUMBER_VALUE  as cardcredits_amount,
       T6.NUMBER_VALUE  as garant_credits_amount,
       T7.NUMBER_VALUE  as energycredits_amount,
       T8.NUMBER_VALUE  as cards_amount,
       T9.NUMBER_VALUE  as accounts_amount,
       T10.NUMBER_VALUE as individual_safes_amount,
       T11.NUMBER_VALUE as cashloans_amount,
       T12.NUMBER_VALUE as bpk_creditline_amount,
       T13.NUMBER_VALUE as insurance_avtocivilka_amount,
       T14.NUMBER_VALUE as insurance_avtocivilkaplus_amnt,
       T15.NUMBER_VALUE as insurance_oberig_amount,
       T16.NUMBER_VALUE as insurance_cash_amount,
       T17.NUMBER_VALUE as card_credit_prime,
       T18.NUMBER_VALUE as MOBILE_SAVING,
       T19.NUMBER_VALUE as OSHAD_ACTIVE

  from customer c
  left join (select OBJECT_ID, min(NUMBER_VALUE) keep (dense_rank last order by VALUE_DATE) as NUMBER_VALUE
             from BARS.ATTRIBUTE_VALUE_BY_DATE where attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_SEGMENT_PRODUCTS_AMNT')
               group by OBJECT_ID) t2 on (c.RNK =  T2.OBJECT_ID)
			   
  left join BARS.ATTRIBUTE_VALUE  t3 on (c.RNK =  T3.OBJECT_ID) and  T3.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_DPT')
  left join BARS.ATTRIBUTE_VALUE  t4 on (c.RNK =  T4.OBJECT_ID) and  T4.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CREDITS')
  left join BARS.ATTRIBUTE_VALUE  t5 on (c.RNK =  T5.OBJECT_ID) and  T5.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CRDCARDS')
  left join BARS.ATTRIBUTE_VALUE  t6 on (c.RNK =  T6.OBJECT_ID) and  T6.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CRD_GARANT')
  left join BARS.ATTRIBUTE_VALUE  t7 on (c.RNK =  T7.OBJECT_ID) and  T7.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CRDENERGY')
  left join BARS.ATTRIBUTE_VALUE  t8 on (c.RNK =  T8.OBJECT_ID) and  T8.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CARDS')
  left join BARS.ATTRIBUTE_VALUE  t9 on (c.RNK =  T9.OBJECT_ID) and  T9.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_ACC')
  left join BARS.ATTRIBUTE_VALUE t10 on (c.RNK = T10.OBJECT_ID) and T10.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_INDIVIDUAL_SAFES')
  left join BARS.ATTRIBUTE_VALUE t11 on (c.RNK = T11.OBJECT_ID) and T11.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CASHLOANS')
  left join BARS.ATTRIBUTE_VALUE t12 on (c.RNK = T12.OBJECT_ID) and T12.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_BPK_CREDITLINE')
  left join BARS.ATTRIBUTE_VALUE t13 on (c.RNK = T13.OBJECT_ID) and T13.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA')
  left join BARS.ATTRIBUTE_VALUE t14 on (c.RNK = T14.OBJECT_ID) and T14.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA+')
  left join BARS.ATTRIBUTE_VALUE t15 on (c.RNK = T15.OBJECT_ID) and T15.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_INSURANCE_OBERIG')
  left join BARS.ATTRIBUTE_VALUE t16 on (c.RNK = T16.OBJECT_ID) and T16.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_INSURANCE_CASH')
  left join BARS.ATTRIBUTE_VALUE t17 on (c.RNK = T17.OBJECT_ID) and T17.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CARD_CREDIT_PRIME')  
  left join BARS.ATTRIBUTE_VALUE t18 on (c.RNK = T18.OBJECT_ID) and T18.attribute_id in (select id from attribute_kind where attribute_code = 'MOBILE_SAVING')  
  left join BARS.ATTRIBUTE_VALUE t19 on (c.RNK = T19.OBJECT_ID) and T19.attribute_id in (select id from attribute_kind where attribute_code = 'OSHAD_ACTIVE') 
 where T2.NUMBER_VALUE is not null;

PROMPT *** Create  grants  V_CUSTOMER_SEGMENTS_CAPACITY ***
grant SELECT                                                                 on V_CUSTOMER_SEGMENTS_CAPACITY to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUSTOMER_SEGMENTS_CAPACITY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_SEGMENTS_CAPACITY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS_CAPACITY.sql ======
PROMPT ===================================================================================== 
