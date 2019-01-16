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

begin
delete from sw_dictionary_status_mt196;


Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('CNCL/', '�����������', 'ʳ����� �������, ��� ��������� ���������� ������� ����� � ������� �� ���������� ���������� ���');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('PDCR/', '������������', '�������� ������, �� ��������� �������� ������ gSRP, ��� ������� ��������� ������ ��� ���������');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('PDCR/INDM', '������� ����������� �� ����������', '������� ����������� �� ����������');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('PDCR/PTNA', '��������� ���������� ������', '���������� ���� �������� ���������� ������ � ������� �������');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('PDCR/RQDA', '������� ����������� � �����������', '������ ������������ ��������� ��� ���������� �������.');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR', '³��������', 'ʳ����� ������� � ��������� ������ ���������� �� �����������. � ����� ������� ������� ������� �');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/AC04', '����� ������� ��������', '���������� ����� ������� �������� � �������� ������ ����������');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/AGNT', '�����������, ���� ���������� �� ����� �����������', '�����������, ���� ���������� �� ����� ����������� ����� ������ ������ ��������� �����');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/AM04', '���� ����� ����������', '���� �����, ������� ��� �������� ����, ��������� � ����������, ����������.');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/ARDT', '���������� �� ����������', '���������� �� ����������, ������� ���������� ��� ���������.');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/CUST', '���������� �� ����� �����������', '�����������, ���� ���������� �� ����� ����������� � ��''���� � ������� �볺��� (���������)');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/INDM', '������� ����������� �� ����������', '������� ����������� �� ����������.');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/LEGL', '�� ����� ����������� � ������������ ������', '�����������, ���� ���������� �� ����� ����������� � ������������ ������');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/NOAS', '���� ������ �������� ����������', '���� ������ �������� ���������� (�� ����� ��� ����������)');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/NOOR', '�������� ���������� ����� �� ���� ��������', '�������� ���������� (��� ����� ���������) ����� �� ���� ��������');

end;
/
commit
/
