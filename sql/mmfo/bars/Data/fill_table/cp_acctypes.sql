begin 
  execute immediate 
    ' insert into cp_acctypes(type,name) values (''RD'',''��������'')';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    ' insert into cp_acctypes(type,name) values (''S2'',''������� ���������� �� �������'')';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    ' insert into cp_acctypes(type,name) values (''SDM'',''�������/����� �����������'')';
exception when dup_val_on_index then 
  null;
end;
/


commit;
