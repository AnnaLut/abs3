begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('01', '�������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('02', '���� (���)');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('03', '����������� �����');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('04', '�������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('05', '�������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('06', '���� ���� ������ (��� �������, ���������)');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
begin
  insert into   cp_ob_form_calc (code ,  txt)
           values ('07', '���������� ���������� �������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
