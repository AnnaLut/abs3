

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/CUSTOMERS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table CUSTOMERS ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.CUSTOMERS 
   (	ID NUMBER(38,0), 
	PER_ID NUMBER, 
	KF VARCHAR2(12), 
	RU NUMBER(*,0), 
	RNK NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	LAST_NAME VARCHAR2(50), 
	FIRST_NAME VARCHAR2(50), 
	MIDDLE_NAME VARCHAR2(60), 
	SEX CHAR(1), 
	GR VARCHAR2(30), 
	BDAY DATE, 
	PASSP NUMBER(*,0), 
	SER VARCHAR2(10), 
	NUMDOC VARCHAR2(20), 
	PDATE DATE, 
	ORGAN VARCHAR2(70), 
	PASSP_EXPIRE_TO DATE, 
	PASSP_TO_BANK DATE, 
	OKPO VARCHAR2(14), 
	CUST_STATUS VARCHAR2(20), 
	CUST_ACTIVE NUMBER(38,0), 
	TELM VARCHAR2(20), 
	TELW VARCHAR2(20), 
	TELD VARCHAR2(20), 
	TELADD VARCHAR2(20), 
	EMAIL VARCHAR2(100), 
	ADR_POST_DOMAIN VARCHAR2(30), 
	ADR_POST_REGION VARCHAR2(30), 
	ADR_POST_LOC VARCHAR2(30), 
	ADR_POST_ADR VARCHAR2(100), 
	ADR_POST_ZIP VARCHAR2(20), 
	ADR_FACT_DOMAIN VARCHAR2(30), 
	ADR_FACT_REGION VARCHAR2(30), 
	ADR_FACT_LOC VARCHAR2(30), 
	ADR_FACT_ADR VARCHAR2(100), 
	ADR_FACT_ZIP VARCHAR2(20), 
	ADR_WORK_DOMAIN VARCHAR2(30), 
	ADR_WORK_REGION VARCHAR2(30), 
	ADR_WORK_LOC VARCHAR2(30), 
	ADR_WORK_ZIP VARCHAR2(20), 
	NEGATIV_STATUS VARCHAR2(10), 
	REESTR_MOB_BANK VARCHAR2(10), 
	REESTR_INET_BANK VARCHAR2(10), 
	REESTR_SMS_BANK VARCHAR2(10), 
	MONTH_INCOME NUMBER(10,0), 
	SUBJECT_ROLE VARCHAR2(10), 
	REZIDENT VARCHAR2(10), 
	MERRIED VARCHAR2(10), 
	EMP_STATUS VARCHAR2(10), 
	SUBJECT_CLASS VARCHAR2(10), 
	INSIDER VARCHAR2(10), 
	ADR_WORK_ADR VARCHAR2(55), 
	ADR_POST_COUNTRY VARCHAR2(55), 
	ADR_FACT_COUNTRY VARCHAR2(55), 
	ADR_WORK_COUNTRY VARCHAR2(55), 
	VIPK NUMBER(1,0), 
	VIP_FIO_MANAGER VARCHAR2(250), 
	VIP_PHONE_MANAGER VARCHAR2(30), 
	DATE_ON DATE, 
	DATE_OFF DATE, 
	EDDR_ID VARCHAR2(20), 
	ACTUAL_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.CUSTOMERS IS 'Գ���� �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.PER_ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.KF IS '���';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.RU IS '��';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.RNK IS '������������� �볺���';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.BRANCH IS '³�������, �� ���� ���������� �볺��';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.LAST_NAME IS '������� ������������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.FIRST_NAME IS '��'� ������������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.MIDDLE_NAME IS '��-������� ������������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.SEX IS '�����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.GR IS '������������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.BDAY IS '���� ����������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.PASSP IS '��� ���������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.SER IS '���� ���������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.NUMDOC IS '� ���������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.PDATE IS '���� ������ ���������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ORGAN IS '̳��� ������ ���������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.PASSP_EXPIRE_TO IS '�������� ������ ��';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.PASSP_TO_BANK IS '���� ����������� ��������� �� �������� �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.OKPO IS '���';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.CUST_STATUS IS '������ �볺��� (��������/����������) ';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.CUST_ACTIVE IS '��� ��������� �볺��� ';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.TELM IS '�������� �������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.TELW IS '������� �������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.TELD IS '���������� (�������) �������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.TELADD IS '���������� �������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.EMAIL IS '������ ���������� �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_POST_DOMAIN IS '������ ����������: �������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_POST_REGION IS '������ ����������: �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_POST_LOC IS '������ ����������: ��������� �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_POST_ADR IS '������ ����������: ������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_POST_ZIP IS '������ ����������: �������� ������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_FACT_DOMAIN IS '������ ���������: �������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_FACT_REGION IS '������ ���������: �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_FACT_LOC IS '������ ���������: ��������� �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_FACT_ADR IS '������ ���������: ������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_FACT_ZIP IS '������ ���������: �������� ������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_WORK_DOMAIN IS '̳��� ������: �������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_WORK_REGION IS '̳��� ������: �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_WORK_LOC IS '̳��� ������: ��������� �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_WORK_ZIP IS '̳��� ������: �������� ������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.NEGATIV_STATUS IS '���������� ������ (D05)';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.REESTR_MOB_BANK IS '��������� � ��������� ������� ';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.REESTR_INET_BANK IS '��������� � ��������-�������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.REESTR_SMS_BANK IS '��������� � SMS-�������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.MONTH_INCOME IS '�������� ������� �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.SUBJECT_ROLE IS '���� ��� ���`���� (D02)';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.REZIDENT IS '�������� (D03)';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.MERRIED IS 'ѳ������ ���� (D08)';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.EMP_STATUS IS '������ ��������� ����� (D09)';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.SUBJECT_CLASS IS '������������ ���`���� (D01)';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.INSIDER IS '������ ������������ �� ��������� �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_WORK_ADR IS '̳��� ������: ������';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_POST_COUNTRY IS '������ ����������: �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_FACT_COUNTRY IS '������ ���������: �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ADR_WORK_COUNTRY IS '̳��� ������: �����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.VIPK IS '�������� ��������� VIP_K';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.VIP_FIO_MANAGER IS 'ϲ� ���������� �� ²�';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.VIP_PHONE_MANAGER IS '������� ���������� �� ²�';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.DATE_ON IS '���� �������� �볺���';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.DATE_OFF IS '���� �������� �볺���';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.EDDR_ID IS '��������� ����� ������ � ����';
COMMENT ON COLUMN BARS_DM.CUSTOMERS.ACTUAL_DATE IS 'ĳ����� ��';




PROMPT *** Create  constraint SYS_C00120084 ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMERS ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS ADD CONSTRAINT PK_CUSTOMERS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS ADD CONSTRAINT CC_CUSTOMERS_BRANCH_NN CHECK (BRANCH IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS ADD CONSTRAINT CC_CUSTOMERS_MFO_NN CHECK (KF IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS ADD CONSTRAINT CC_CUSTOMERS_PERID_NN CHECK (PER_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CUSTOMERS ADD CONSTRAINT CC_CUSTOMERS_RNK_NN CHECK (RNK IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CUSTOMERS_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_CUSTOMERS_PERID ON BARS_DM.CUSTOMERS (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.PK_CUSTOMERS ON BARS_DM.CUSTOMERS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMERS ***
grant SELECT                                                                 on CUSTOMERS       to BARS;
grant SELECT                                                                 on CUSTOMERS       to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTOMERS       to BARSUPL;
grant SELECT                                                                 on CUSTOMERS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/CUSTOMERS.sql =========*** End *** 
PROMPT ===================================================================================== 
