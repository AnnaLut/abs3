begin
  insert into params$global
    (par, val, comm, srv_flag)
  values
    ('W4CHEKLIM',
     '0',
     'Way4. �������� ���� �� �������� �� ������ ��������(1-���, 0-����.)',
     0);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
