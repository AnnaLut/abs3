begin 
  execute immediate 
    ' insert into tips(tip, name) values (''SR'',''���������� �� ���. �������'')';
exception when dup_val_on_index then 
  null;
end;
/
