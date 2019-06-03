begin 
insert into f012 (F012, TXT, D_OPEN, D_CLOSE, D_MODI)
values (1, 'Більше 50%, та не становить 100% - державна', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f012 (F012, TXT, D_OPEN, D_CLOSE, D_MODI)
values (2, '100% - казенна', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f012 (F012, TXT, D_OPEN, D_CLOSE, D_MODI)
values (3, 'Менше 50% - змішана', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f012 (F012, TXT, D_OPEN, D_CLOSE, D_MODI)
values (4, '0% - приватна', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/
commit;