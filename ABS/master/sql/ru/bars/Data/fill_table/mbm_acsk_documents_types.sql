SET DEFINE OFF;

begin Insert into MBM_ACSK_DOCUMENTS_TYPES (ID, NAME) Values ( 1, '������� ����������� ������');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_DOCUMENTS_TYPES (ID, NAME) Values ( 2, '����������� �������');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_DOCUMENTS_TYPES (ID, NAME) Values ( 3, '������� ����������� ���� �������');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_DOCUMENTS_TYPES (ID, NAME) Values ( 4, '�������� ����� ��� ������������');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_DOCUMENTS_TYPES (ID, NAME) Values ( 5, '����');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

COMMIT;
