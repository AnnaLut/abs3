begin
   begin insert into cust_access_types values ('R', '��� ������'); exception when dup_val_on_index then null; end;
   begin insert into cust_access_types values ('RW',   '��� ������ � ��������������'); exception when dup_val_on_index then null; end;
   begin insert into cust_access_types values ('NA',   '���������� ��� ���������'); exception when dup_val_on_index then null; end;
end;
/
commit;
   