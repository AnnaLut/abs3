begin 
  execute immediate 
    ' insert into ACCP_ORDER_FEE(id,text) values (1,''� ������� �������'')';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    ' insert into ACCP_ORDER_FEE(id,text) values (2,''� �������� ���� ����������� ������� �� ����'')';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    ' insert into ACCP_ORDER_FEE(id,text) values (3,''� �������� ���� ����������� ������� �� �����'')';
exception when dup_val_on_index then 
  null;
end;
/

commit;
