PROMPT *** Refresh data ead_types ***

set constraints all deferred;

delete from ead_types;

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('DICT', '�������', 'SetDictionaryData', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('CLIENT', '�볺��', 'SetClientData', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('UCLIENT', '��i��� - ��.�����', 'SetClientDataU', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('ACC', '������� Գ�.�����', 'SetAccountData', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('UACC', '������� ��.�����', 'SetAccountDataU', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('AGR', '�����', 'SetAgreementData', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('UAGR', '����� ��.�����', 'SetAgreementDataU', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('ACT', '����������� �����. ���������', 'ActualizeIdDocs', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('DOC', '������������ ��������', 'SetDocumentData', 4320, 5);

commit work;