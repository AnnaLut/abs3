begin
  insert into params$global
    (par, val, comm, srv_flag)
  values
    ('W4CHEKLIM',
     '0',
     'Way4. ѕерев≥рка л≥м≥ту по платежам на дов≥льн≥ рекв≥зити(1-вкл, 0-викл.)',
     0);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
