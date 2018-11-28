

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BILLS/Table/OPERS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  table OPERS ***
begin 
  execute immediate '
  CREATE TABLE BILLS.OPERS 
   (	ID NUMBER(*,0), 
	OPER_DT DATE, 
	DBT VARCHAR2(14), 
	CRD VARCHAR2(14), 
	AMOUNT NUMBER, 
	STATE VARCHAR2(2), 
	DOC_REF NUMBER, 
	CUR_CODE VARCHAR2(3), 
	PURPOSE VARCHAR2(160), 
	MFO NUMBER, 
	MESSAGE VARCHAR2(1000), 
	USER_REF VARCHAR2(30), 
	LAST_DT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BILLS.OPERS IS '';
COMMENT ON COLUMN BILLS.OPERS.ID IS 'id ������';
COMMENT ON COLUMN BILLS.OPERS.OPER_DT IS '���� ��������';
COMMENT ON COLUMN BILLS.OPERS.DBT IS '�����';
COMMENT ON COLUMN BILLS.OPERS.CRD IS '������';
COMMENT ON COLUMN BILLS.OPERS.AMOUNT IS '����';
COMMENT ON COLUMN BILLS.OPERS.STATE IS '������ ��������';
COMMENT ON COLUMN BILLS.OPERS.MESSAGE IS '����������� ��� �������';
COMMENT ON COLUMN BILLS.OPERS.DOC_REF IS '��������� �� �������� � ���';
COMMENT ON COLUMN BILLS.OPERS.CUR_CODE IS '������';
COMMENT ON COLUMN BILLS.OPERS.PURPOSE IS '����������� �������';
COMMENT ON COLUMN BILLS.OPERS.MFO IS '���';
COMMENT ON COLUMN BILLS.OPERS.USER_REF IS '����������, ���� �������/������ �����';
COMMENT ON COLUMN BILLS.OPERS.LAST_DT IS '������� ���� ���������';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BILLS/Table/OPERS.sql =========*** End *** ======
PROMPT ===================================================================================== 
