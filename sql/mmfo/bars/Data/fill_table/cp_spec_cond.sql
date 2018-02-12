begin
  insert into   cp_spec_cond (id ,  title)
           values (1, 'З двостороннім котируванням');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert into   cp_spec_cond (id ,  title)
           values (2, 'Індексовані');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert into   cp_spec_cond (id ,  title)
           values (3, 'Валютні');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert into   cp_spec_cond (id ,  title)
           values (4, 'ОВДП-ПДВ');
exception when dup_val_on_index then null;
          when others then raise;
end;
/


commit;