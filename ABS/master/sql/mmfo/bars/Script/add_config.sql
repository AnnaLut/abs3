begin
  insert into web_barsconfig
    (grouptype, key, csharptype, val, comm)
  values
    (1,
     'Module.Accounts.EnhanceCloseCheck',
     null,
     1,
     '����� ���������� �������� �����');
     commit;
exception
  when dup_val_on_index then
    update web_barsconfig w
       set w.key  = 1,
           w.comm = '����� ���������� �������� �����'
     where w.key = 'Module.Accounts.EnhanceCloseCheck';
    commit;
end;
