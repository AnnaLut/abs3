begin
bars_policy_adm.alter_policy_info('sw_dictionary_status_mt192', 'FILIAL', null, 'E', 'E','E');
bars_policy_adm.alter_policy_info('sw_dictionary_status_mt192', 'WHOLE', null, null,null,null);
end;
/


begin
execute immediate 'create table sw_dictionary_status_mt192(id varchar2(20), name varchar2(50), description varchar2(100))';
exception when others then if(sqlcode=-955) then null; else raise; end if;
end;
/

begin
execute immediate 'ALTER TABLE BARS.SW_DICTIONARY_STATUS_MT192 ADD 
CONSTRAINT PK_SW_DICTIONARY_STATUS_MT192
 PRIMARY KEY (ID)
 ENABLE
 VALIDATE';
exception when others then if(sqlcode=-2260) then null; else raise; end if;
end;
/ 


begin
bars_policy_adm.alter_policies('sw_dictionary_status_mt192');
end;
/
commit
/

begin
delete from sw_dictionary_status_mt192;

insert into sw_dictionary_status_mt192(id, name, description) values('DUPL','������� �������','����� � ��������� ������ �������.');
insert into sw_dictionary_status_mt192(id, name, description) values('AGNT','������� �����','������� ����� � �������� ������ �������.');
insert into sw_dictionary_status_mt192(id, name, description) values('CURR','������ ������','������ ������ �������.');
insert into sw_dictionary_status_mt192(id, name, description) values('CUST','��������� �볺����','���������� ��������� ���������.');
insert into sw_dictionary_status_mt192(id, name, description) values('UPAY','�������������� �����','����� �� � ������������.');
insert into sw_dictionary_status_mt192(id, name, description) values('CUTA','���������� ���� ����������� ���������','���� ��������� ����������, ������� ��� ��������� ����� ��� ������������, �� ����������� ���������.');
insert into sw_dictionary_status_mt192(id, name, description) values('TECH','������� ��������','����� ��� ���������� �������� �������� �������, �� �������� �� ��������� ����������.');
insert into sw_dictionary_status_mt192(id, name, description) values('FRAD','�������� ����������','����� ��� ���������� �������� ����������, ��� ���� ���� �������� ����������.');
insert into sw_dictionary_status_mt192(id, name, description) values('COVR','�������� ���������� ��� ���������','����� � �������� ��� ��� ����������, ��� �����������.');
insert into sw_dictionary_status_mt192(id, name, description) values('AMNT','������ ����','������ ���� �������.');
end;
/
commit
/

