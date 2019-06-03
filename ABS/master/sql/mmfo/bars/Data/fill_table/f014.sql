begin 
insert into f014 (F014, TXT, D_OPEN, D_CLOSE, D_MODI)
values ('A', 'первісний', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/
begin 
insert into f014 (F014, TXT, D_OPEN, D_CLOSE, D_MODI)
values ('B', 'повторний', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/
commit;