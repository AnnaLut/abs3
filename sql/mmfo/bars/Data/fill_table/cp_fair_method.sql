begin
  insert into   cp_fair_method (id ,  title)
           values (1, 'Ринкова вартість');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert into   cp_fair_method (id ,  title)
           values (2, 'Собівартість');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert into   cp_fair_method (id ,  title)
           values (3, 'Справедлива вартість визначена за допомогою ринкового, доходного або витратного підходу');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

commit;