begin
   begin insert into cust_access_fields values ('TEL_MOBILE', '�������� �������'); exception when dup_val_on_index then null; end;
   begin insert into cust_access_fields values ('TEL_HOME',   '������� �������'); exception when dup_val_on_index then null; end;
end;
/
commit;
   
