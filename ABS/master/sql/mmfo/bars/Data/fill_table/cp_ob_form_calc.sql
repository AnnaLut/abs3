begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('01', 'Грошова');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('02', 'Обмін (міна)');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('03', 'Корпоративні права');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('04', 'Заставні');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('05', 'Вексель');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('06', 'Інші цінні папери (крім векселів, заставних)');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('07', 'Поповнення статутного капіталу');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
