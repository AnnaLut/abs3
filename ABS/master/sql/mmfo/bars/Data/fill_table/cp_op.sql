begin
  insert into   cp_op (op ,  name)
           values ('30', 'Дисконт/Премія від модифікації');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
commit;
