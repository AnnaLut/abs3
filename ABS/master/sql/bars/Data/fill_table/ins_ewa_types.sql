begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''��'', ''�������� ������� (�����)'', 12)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''���'', ''������'', 24)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''в�'', ''����������� �������� ����'', 23)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''��'', ''����������� ����� (cash) ��'', 25)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''policy'', ''�����'', 14)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''vcl'', ''��� (������������ ����������� ���������������)'', 14)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''greencard'', ''������ �����'', 14)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''custom'', ''������������� ��� ��������: ����� �����, �� � ������������ ���, ����� ����������� ����� � ������������� ���'', 14)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''��'', ''���� (����������)'', 14)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''���'', ''��� (����������+)'', 16)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''���'', ''��� (˳��� � �����)'', 18)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''��'', ''����� (������� ������)'', 2)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''��'', ''�� ������''''�'', 26)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''000000000000000000000000000000'', ''Default'', null)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''���'', ''�������� ��� ������'', 18)');
exception when dup_val_on_index then null;
end;
/
COMMIT;
/
