begin
  insert into   cp_spec_cond (id ,  title)
           values (1, '� ����������� ������������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert into   cp_spec_cond (id ,  title)
           values (2, '����������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert into   cp_spec_cond (id ,  title)
           values (3, '������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert into   cp_spec_cond (id ,  title)
           values (4, '����-���');
exception when dup_val_on_index then null;
          when others then raise;
end;
/


commit;