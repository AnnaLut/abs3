begin
  insert
  into   crkr_ca_transfer_state (state_id ,
                   state_name)
           values (0,
                   'Необроблений');
exception when dup_val_on_index then null;
          when others then raise;
end;
/


begin
  insert
  into   crkr_ca_transfer_state (state_id ,
                   state_name)
           values (10,
                   'Створений платіж');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert
  into   crkr_ca_transfer_state (state_id ,
                   state_name)
           values (11,
                   'Оплачений документ');
exception when dup_val_on_index then null;
          when others then raise;
end;
/


begin
  insert
  into   crkr_ca_transfer_state (state_id ,
                   state_name)
           values (20,
                   'Помилка фази створення платежу');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert
  into   crkr_ca_transfer_state (state_id ,
                   state_name)
           values (21,
                   'Помилка фази накладання візи');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
