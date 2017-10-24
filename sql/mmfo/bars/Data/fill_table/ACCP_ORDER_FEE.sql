begin 
  execute immediate 
    ' insert into ACCP_ORDER_FEE(id,text) values (1,''з кожного платежу'')';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    ' insert into ACCP_ORDER_FEE(id,text) values (2,''з загальної суми відправлених платежів за день'')';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    ' insert into ACCP_ORDER_FEE(id,text) values (3,''з загальної суми відправлених платежів за місяць'')';
exception when dup_val_on_index then 
  null;
end;
/

commit;
