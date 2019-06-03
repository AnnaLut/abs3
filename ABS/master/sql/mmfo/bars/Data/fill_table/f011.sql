begin 
insert into f011 (F011, TXT, D_OPEN, D_CLOSE, D_MODI)
values (1, 'рівні суми', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/


begin 
insert into f011 (F011, TXT, D_OPEN, D_CLOSE, D_MODI)
values (2, 'одноразова плата', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f011 (F011, TXT, D_OPEN, D_CLOSE, D_MODI)
values (3, 'Інше', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/
commit;