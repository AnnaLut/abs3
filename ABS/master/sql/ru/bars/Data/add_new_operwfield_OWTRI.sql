begin
  insert into op_field
    (tag, name, use_in_arch)
  values
    ('OWTRI', 'OW. ����� ���������� Way4', 0);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
