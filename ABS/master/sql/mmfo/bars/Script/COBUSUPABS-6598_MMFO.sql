-- MMFO
declare
  AttrCodes SYS.ODCINumberList;
begin
  select id bulk collect into AttrCodes from bars.attribute_kind
   where attribute_code = any(
'CUSTOMER_SEGMENT_ACTIVITY',
'CUSTOMER_SEGMENT_FINANCIAL',
'CUSTOMER_SEGMENT_BEHAVIOR',
'CUSTOMER_SEGMENT_TRANSACTIONS',
'CUSTOMER_SEGMENT_ATM',
'CUSTOMER_SEGMENT_BPK_CREDITLINE',
'CUSTOMER_SEGMENT_CASHCREDIT_GIVEN',
'CUSTOMER_SEGMENT_PRODUCTS_AMNT',
'CUSTOMER_SEGMENT_TVBV',
'CUSTOMER_PRDCT_AMNT_CREDITS',
'CUSTOMER_PRDCT_AMNT_DPT',
'CUSTOMER_PRDCT_AMNT_CRDCARDS',
'CUSTOMER_PRDCT_AMNT_CRDENERGY',
'CUSTOMER_PRDCT_AMNT_CRD_GARANT',
'CUSTOMER_PRDCT_AMNT_ACC',
'CUSTOMER_PRDCT_AMNT_CARDS',
'CUSTOMER_PRDCT_AMNT_CASHLOANS',
'CUSTOMER_PRDCT_AMNT_BPK_CREDITLINE',
'CUSTOMER_PRDCT_AMNT_INDIVIDUAL_SAFES',
'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA',
'CUSTOMER_PRDCT_AMNT_INSURANCE_AVTOCIVILKA+',
'CUSTOMER_PRDCT_AMNT_INSURANCE_OBERIG',
'CUSTOMER_PRDCT_AMNT_INSURANCE_CASH');

  forall i in AttrCodes.First .. AttrCodes.Last
    update bars.attribute_history
       set valid_from = valid_from + NumToYMInterval(2000, 'YEAR')
     where attribute_id = AttrCodes(i)
       and valid_from < date '0018-01-01';

  commit work;
  dbms_output.put_line('commet 1'); 

	forall i in AttrCodes.First .. AttrCodes.Last
    update bars.attribute_value_by_date
       set value_date = value_date + NumToYMInterval(2000, 'YEAR')
     where attribute_id = AttrCodes(i)
       and value_date < date '0018-01-01';

  commit work;
  dbms_output.put_line('commet 2'); 
exception
  when others then
    dbms_output.put_line('roll'); 
    dbms_output.put_line(dbms_utility.format_error_stack || dbms_utility.format_error_backtrace); 
    rollback;
end;
/