prompt Importing table bars.P_MIGRAASIMM...

delete from bars.P_MIGRAASIMM;
begin 
  execute immediate 
    'insert into bars.P_MIGRAASIMM (ACTION, PROCNAME, ERRMASK, ORDNUNG, PROV_SQL, DATE_BEGIN, DATE_END, DONE, ERR, N, MISTAKE_SHOW, PASTEID)
values (''�������� ������ ����������� ������� ���� � ����'', ''sk_test.sk_test'', ''create_tblASIM - err'', 1, null, null, null, null, null, 1, ''��� �� ��������'', '''')';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    '
insert into bars.P_MIGRAASIMM (ACTION, PROCNAME, ERRMASK, ORDNUNG, PROV_SQL, DATE_BEGIN, DATE_END, DONE, ERR, N, MISTAKE_SHOW, PASTEID)
values (''������ ����������� �������'', ''sk_test.create_dptASIM_'', ''%create_dptASIM - err%'', 2, null, null, null, null, null, 2, ''��� �� ��������'', '''')';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    ' insert into bars.P_MIGRAASIMM (ACTION, PROCNAME, ERRMASK, ORDNUNG, PROV_SQL, DATE_BEGIN, DATE_END, DONE, ERR, N, MISTAKE_SHOW, PASTEID)
values (''�������� �1 (�-�� � ����� �� �� � ��22)'', null, null, 3, ''PROV31'', null, null, null, null, 3, null, '''')';
exception when dup_val_on_index then 
  null;
end;
/
begin 
  execute immediate 
    'insert into bars.P_MIGRAASIMM (ACTION, PROCNAME, ERRMASK, ORDNUNG, PROV_SQL, DATE_BEGIN, DATE_END, DONE, ERR, N, MISTAKE_SHOW, PASTEID)
values (''������������ �������� ������'', ''sk_test.migraAS.load_IM4KOTL2S'', ''%load_IM4KOTL2S - err%'', 4, null, null, null, null, null, 4, ''��� �� ��������'', '''')';
exception when dup_val_on_index then 
  null;
end;
/
begin 
  execute immediate 
    'insert into bars.P_MIGRAASIMM (ACTION, PROCNAME, ERRMASK, ORDNUNG, PROV_SQL, DATE_BEGIN, DATE_END, DONE, ERR, N, MISTAKE_SHOW, PASTEID)
values (''����� ������������ �������� ������'', ''sk_test.migraAS.drop_IM4KOTL2S'', ''%drop_IM4KOTL2S - err%'', 5, null, null, null, null, null, 5, ''��� �� ��������'', '''')';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    '
insert into bars.P_MIGRAASIMM (ACTION, PROCNAME, ERRMASK, ORDNUNG, PROV_SQL, DATE_BEGIN, DATE_END, DONE, ERR, N, MISTAKE_SHOW, PASTEID)
values (''����� ����������� �������'', ''sk_test.migraAS.drop_deposASIM'', ''%drop_deposASIM - err%'', 6, null, null, null, null, null, 6, ''��� �� ��������'', '''')';
exception when dup_val_on_index then 
  null;
end;
/

commit;

prompt Done....bars.P_MIGRAASIMM














