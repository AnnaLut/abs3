create or replace view bars.v_customer_segments_capacity as
select c.rnk     as rnk,
       T2.VALUE  as product_amount,
       T3.VALUE  as deposit_amount,
       T4.VALUE  as credits_amount,
       T5.VALUE  as cardcredits_amount,
       T6.VALUE  as garant_credits_amount,
       T7.VALUE  as energycredits_amount,
       T8.VALUE  as cards_amount,
       T9.VALUE  as accounts_amount,
       T10.VALUE as individual_safes_amount,
       T11.VALUE as cashloans_amount,
       T12.VALUE as bpk_creditline_amount,
       T13.VALUE as insurance_avtocivilka_amount,
       T14.VALUE as insurance_avtocivilkaplus_amnt,
       T15.VALUE as insurance_oberig_amount,
       T16.VALUE as insurance_cash_amount
  from customer c
  left join BARS.ATTRIBUTE_NUMBER_VALUE  t2 on (c.RNK =  T2.OBJECT_ID) and  T2.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_SEGMENT_PRODUCTS_AMNT')
  left join BARS.ATTRIBUTE_NUMBER_VALUE  t3 on (c.RNK =  T3.OBJECT_ID) and  T3.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_DPT')
  left join BARS.ATTRIBUTE_NUMBER_VALUE  t4 on (c.RNK =  T4.OBJECT_ID) and  T4.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CREDITS')
  left join BARS.ATTRIBUTE_NUMBER_VALUE  t5 on (c.RNK =  T5.OBJECT_ID) and  T5.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CRDCARDS')
  left join BARS.ATTRIBUTE_NUMBER_VALUE  t6 on (c.RNK =  T6.OBJECT_ID) and  T6.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CRD_GARANT')
  left join BARS.ATTRIBUTE_NUMBER_VALUE  t7 on (c.RNK =  T7.OBJECT_ID) and  T7.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CRDENERGY')
  left join BARS.ATTRIBUTE_NUMBER_VALUE  t8 on (c.RNK =  T8.OBJECT_ID) and  T8.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CARDS')
  left join BARS.ATTRIBUTE_NUMBER_VALUE  t9 on (c.RNK =  T9.OBJECT_ID) and  T9.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_ACC')
  left join BARS.ATTRIBUTE_NUMBER_VALUE t10 on (c.RNK = T10.OBJECT_ID) and T10.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_INDIVIDUAL_SAFES')
  left join BARS.ATTRIBUTE_NUMBER_VALUE t11 on (c.RNK = T11.OBJECT_ID) and T11.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_CASHLOANS')
  left join BARS.ATTRIBUTE_NUMBER_VALUE t12 on (c.RNK = T12.OBJECT_ID) and T12.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_BPK_CREDITLINE')
  left join BARS.ATTRIBUTE_NUMBER_VALUE t13 on (c.RNK = T13.OBJECT_ID) and T13.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA')
  left join BARS.ATTRIBUTE_NUMBER_VALUE t14 on (c.RNK = T14.OBJECT_ID) and T14.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA+')
  left join BARS.ATTRIBUTE_NUMBER_VALUE t15 on (c.RNK = T15.OBJECT_ID) and T15.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_INSURANCE_OBERIG')
  left join BARS.ATTRIBUTE_NUMBER_VALUE t16 on (c.RNK = T16.OBJECT_ID) and T16.attribute_id in (select id from attribute_kind where attribute_code = 'CUSTOMER_PRDCT_AMNT_INSURANCE_CASH')
 where T2.VALUE is not null
/
show errors
