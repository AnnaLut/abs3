begin 
insert into f009 (F009, TXT, D_OPEN, D_CLOSE, D_MODI)
values (1, '� ���������� �������', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f009 (F009, TXT, D_OPEN, D_CLOSE, D_MODI)
values (2, '����� ����� ������������', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f009 (F009, TXT, D_OPEN, D_CLOSE, D_MODI)
values (3, '������', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/
commit;