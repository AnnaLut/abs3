update cim_credit_f503_purpose set name = '���� ���' where id = 10;
/
begin
  begin insert into cim_credit_f503_purpose(id, name) values(11, '���������� ������'); exception when dup_val_on_index then null; end;
end;
/
begin
  begin insert into cim_credit_f503_purpose(id, name) values(12, '�������������'); exception when dup_val_on_index then null; end;
end;
/
commit;

