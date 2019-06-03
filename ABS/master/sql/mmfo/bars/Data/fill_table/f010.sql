begin 
insert into f010 (F010, TXT, D_OPEN, D_CLOSE, D_MODI)
values (0, 'звичайна позика', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f010 (F010, TXT, D_OPEN, D_CLOSE, D_MODI)
values (1, 'рефінансування боргу', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f010 (F010, TXT, D_OPEN, D_CLOSE, D_MODI)
values (2, 'реорганізація боргу', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f010 (F010, TXT, D_OPEN, D_CLOSE, D_MODI)
values (3, 'зміна графіку погашення', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f010 (F010, TXT, D_OPEN, D_CLOSE, D_MODI)
values (4, 'Інше', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/
commit;