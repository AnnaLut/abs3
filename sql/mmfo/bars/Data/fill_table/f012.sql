begin 
insert into f012 (F012, TXT, D_OPEN, D_CLOSE, D_MODI)
values (1, '������ 50%, �� �� ��������� 100% - ��������', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f012 (F012, TXT, D_OPEN, D_CLOSE, D_MODI)
values (2, '100% - �������', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f012 (F012, TXT, D_OPEN, D_CLOSE, D_MODI)
values (3, '����� 50% - ������', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f012 (F012, TXT, D_OPEN, D_CLOSE, D_MODI)
values (4, '0% - ��������', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/
commit;