begin
   begin insert into cust_access_types values ('R', 'Для чтения'); exception when dup_val_on_index then null; end;
   begin insert into cust_access_types values ('RW',   'Для чтения и редактирования'); exception when dup_val_on_index then null; end;
   begin insert into cust_access_types values ('NA',   'Недоступно для просмотра'); exception when dup_val_on_index then null; end;
end;
/
commit;
   