prompt bars.tgr - add 5

begin
insert into tgr(name, tgr)
values ('5 - ������� ����. ����� �������� �������', 5);
exception
when dup_val_on_index then null;
end;
/
commit;
/