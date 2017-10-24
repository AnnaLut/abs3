begin
   begin insert into cust_access_fields values ('TEL_MOBILE', 'Мобільний телефон'); exception when dup_val_on_index then null; end;
   begin insert into cust_access_fields values ('TEL_HOME',   'Домашній телефон'); exception when dup_val_on_index then null; end;
end;
/
commit;
   
