Begin
  INSERT INTO BRANCH_ATTRIBUTE(ATTRIBUTE_CODE,ATTRIBUTE_DESC,ATTRIBUTE_DATATYPE,ATTRIBUTE_FORMAT,ATTRIBUTE_MODULE) 
  values('SDO_COUNT_DAY','Кількість днів автооплати помилкового платежу','D','','');

exception when dup_val_on_index then null;
end;
/

begin 
  insert into branch_attribute_value(attribute_code,branch_code,attribute_value)
  values ('SDO_COUNT_DAY','/','30');

exception when dup_val_on_index then null; 
end;
/

COMMIT;