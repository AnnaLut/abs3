prompt k_dfm04

update finmon.k_dfm04 t
set t.name = '������� ����������� ������ � ������ ��������'
where t.code = '1';
/
begin
insert into k_dfm04 (code, name) values ('10', '������� ����������� ������ � ������ ������');
exception
when dup_val_on_index then null;
end;
/
commit;
/