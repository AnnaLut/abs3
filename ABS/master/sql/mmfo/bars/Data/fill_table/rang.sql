prompt fill rang
begin
    insert into rang (rang, name) values (13, '������������, �� ��������, �� ������� �����');
    commit;
exception
    when dup_val_on_index then null;
end;
/