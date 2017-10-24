prompt ------------------------------------------
prompt  �������� ������� EAD_NBS
prompt  �������� ������� ��� ������������ � ��
prompt ------------------------------------------
/

exec bpa.alter_policy_info( 'EAD_NBS', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'EAD_NBS', 'FILIAL', null, null, null, null );
/
begin
  execute immediate 'CREATE TABLE EAD_NBS(NBS CHAR (4 Byte) NOT NULL, CUSTTYPE INT NOT NULL) TABLESPACE brssmld';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE EAD_NBS IS '�������� ������� ��� ������������ � ��';
COMMENT ON COLUMN EAD_NBS.NBS IS '���������� ������� �� ��������';
COMMENT ON COLUMN EAD_NBS.CUSTTYPE IS '���������� ��� ����� ���� �볺���';
/
begin
  execute immediate 'CREATE UNIQUE INDEX PK_EADNBS ON EAD_NBS (NBS,CUSTTYPE) TABLESPACE brssmli';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/
GRANT SELECT ON EAD_NBS TO BARS_ACCESS_DEFROLE;
/
