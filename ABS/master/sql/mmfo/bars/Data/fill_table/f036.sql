begin 
insert into f036 (F036, TXT, D_OPEN, D_CLOSE, D_MODI)
values (0, '����� - � ��� ���� ������������� ���� ��� ��������� ������ �������� ������ ������ 䳿 ��������', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f036 (F036, TXT, D_OPEN, D_CLOSE, D_MODI)
values (1, '����� - � ��� ���� �������� ������ ������ 䳿 �������� �������������� ��� ������ ��������� ������ (����� ������)', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f036 (F036, TXT, D_OPEN, D_CLOSE, D_MODI)
values (2, '����� - � ��� ���� �������� ������ ������ 䳿 �������� �������������� ��� ������ ��������� ������ (����� ������)', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/

begin 
insert into f036 (F036, TXT, D_OPEN, D_CLOSE, D_MODI)
values (3, '���� - � ��� ���� �������� ������ ������ 䳿 �������� �������������� ������� ���������� ������ (��������� �� �������� �� ������ ���������� ��� 10_1 �� ��� 10_2)', to_date('01-07-2018', 'dd-mm-yyyy'), null, null);
    exception when dup_val_on_index then null;
end;
/


commit;