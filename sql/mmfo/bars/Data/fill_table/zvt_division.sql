prompt Importing table zvt_division...

begin
begin insert into ZVT_DIVISION (division_id, name) values (1, '��������� ������������� �������� � ��������� �������'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (2, '��������� ������������� ������� �������������� � ����'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (3, '��������� ������������� �������� �������� �������������� ������'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (4, '���������� ���������'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (5, '��������� ������������� �� �������� �������� �������� ���������� � ����'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (6, '��������� ������������� �� �������� ������� ��������'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (7, '��������� ����� ������������������� �������� ������������ ������� �����'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (8, '��������� ������������� ������� ����� � ������������� ��������'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (9, '��������� ������������� �� �������� �������� �������� ���������� ������'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (10, '��������� ������������� �������'); exception when others then null; end;
end;
/
commit;
prompt Done.