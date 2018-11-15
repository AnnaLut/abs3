

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/CREDITS_DYN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table CREDITS_DYN ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.CREDITS_DYN 
   (	ID NUMBER(15,0), 
	PER_ID NUMBER, 
	ND NUMBER(38,0), 
	RNK NUMBER(15,0), 
	KF VARCHAR2(12), 
	CC_ID VARCHAR2(50), 
	SDATE DATE, 
	BRANCH VARCHAR2(30), 
	VIDD NUMBER(*,0), 
	NEXT_PAY DATE, 
	PROBL_ROZGL VARCHAR2(30), 
	PROBL_DATE DATE, 
	PROBL VARCHAR2(10), 
	CRED_CHANGE VARCHAR2(30), 
	CRED_DATECHANGE DATE, 
	BORG NUMBER(15,2), 
	BORG_TILO NUMBER(15,2), 
	BORG_PROC NUMBER(15,2), 
	PROSR1 DATE, 
	PROSR2 DATE, 
	PROSRCNT NUMBER(*,0), 
	BORG_PROSR NUMBER(15,2), 
	BORG_TILO_PROSR NUMBER(15,2), 
	BORG_PROC_PROSR NUMBER(15,2), 
	PENJA NUMBER(15,2), 
	SHTRAF NUMBER(15,2), 
	PAY_TILO NUMBER(15,2), 
	PAY_PROC NUMBER(15,2), 
	CAT_RYZYK VARCHAR2(30), 
	CRED_TO_PROSR DATE, 
	BORG_TO_PBAL DATE, 
	VART_MAJNA NUMBER(15,2), 
	POG_FINISH DATE, 
	PROSR_FACT_CNT NUMBER(4,0), 
	NEXT_PAY_ALL NUMBER(15,2), 
	NEXT_PAY_TILO NUMBER(15,2), 
	NEXT_PAY_PROC NUMBER(15,2), 
	SOS NUMBER(*,0), 
	LAST_PAY_DATE DATE, 
	LAST_PAY_SUMA NUMBER(15,2), 
	PROSRCNT_PROC NUMBER(*,0), 
	TILO_PROSR_UAH NUMBER(15,2), 
	PROC_PROSR_UAH NUMBER(15,2), 
	BORG_TILO_UAH NUMBER(15,2), 
	BORG_PROC_UAH NUMBER(15,2), 
	PAY_VDVS NUMBER(15,2), 
	AMOUNT_COMMISSION NUMBER(15,2), 
	AMOUNT_PROSR_COMMISSION NUMBER(15,2), 
	ES000 VARCHAR2(24), 
	ES003 VARCHAR2(24), 
	VIDD_CUSTTYPE NUMBER(1,0),
	stp_dat date
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

prompt add column stp_dat
begin
execute immediate 'alter table bars_dm.CREDITS_DYN add stp_dat date';
exception
  when others then
     if sqlcode = -1430 then null;
     else
       raise;
     end if;
end;
/

COMMENT ON TABLE BARS_DM.CREDITS_DYN IS '�������, ������� ���';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.ES000 IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.ES003 IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.VIDD_CUSTTYPE IS '��� ������� �� ���� ��������: 3 - ���������� ����, 2 - ����������� ����, 1 - ����';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PER_ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.ND IS '������������� ��';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.RNK IS '���';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.KF IS '��� ��';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.CC_ID IS '� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.SDATE IS '���� ��������� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BRANCH IS '�����';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.VIDD IS '��� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.NEXT_PAY IS '���� ��������� ���������� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROBL_ROZGL IS '�� ���䳿 �������� ������� ��� �������� ���������� ';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROBL_DATE IS '���� �������� ������� ����������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROBL IS '�������� ������� ����������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.CRED_CHANGE IS '���� ���� ������������ ';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.CRED_DATECHANGE IS '���� ��������� ���� ���� ������������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG IS '���� ������������� �� �������� � ����� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_TILO IS '���� ������������� �� ���� ������� � ����� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_PROC IS '���� ������������� �� ��������� � ����� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROSR1 IS '���� ���������� ����� ���������� �� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROSR2 IS '���� ���������� ����� ���������� �� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROSRCNT IS 'ʳ������ ������������ �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_PROSR IS '���� ����������� ������������� �� �������� � ����� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_TILO_PROSR IS '���� ����������� ������������� �� ���� � ����� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_PROC_PROSR IS '���� ����������� ������������� �� ���������� � ����� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PENJA IS '���� ��� � ����� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.SHTRAF IS '���� ����������� ������� � ����� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PAY_TILO IS '���� ���������� ����� �� ������� � ��������� ����, ���';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PAY_PROC IS '���� ���������� �������� �� �������� � ��������� ����, ���';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.CAT_RYZYK IS '�������� ������ �������� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.CRED_TO_PROSR IS '���� ��������� ������� �� ������� ����������� �������������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_TO_PBAL IS '���� ����������� ������������� �� ������������ �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.VART_MAJNA IS '������� ���������� ����� �� ������, ��� ';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.POG_FINISH IS '����� ���� ��������� ������� ����� � �������� ������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROSR_FACT_CNT IS 'ʳ������ ����� ������ �� ���������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.NEXT_PAY_ALL IS '���� ���������� �������, ������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.NEXT_PAY_TILO IS '���� ���������� �������, ���';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.NEXT_PAY_PROC IS '���� ���������� �������, �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.SOS IS '���� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.LAST_PAY_DATE IS '���� ��������� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.LAST_PAY_SUMA IS '���� ��������� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROSRCNT_PROC IS 'ʳ������ ������������ ����������� ������� �� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.TILO_PROSR_UAH IS '���� ����������� ������������� �� ���� � �����';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROC_PROSR_UAH IS '���� ����������� ������������� �� ��������� � �����';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_TILO_UAH IS '���� ������������� �� ���� � �����';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_PROC_UAH IS '���� ������������� �� ��������� � �����';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PAY_VDVS IS '������ ������������ ����� �� ����, ���.';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.AMOUNT_COMMISSION IS '���� ���� �� �� � ����� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.AMOUNT_PROSR_COMMISSION IS '���� ����������� ���� �� �� � ����� �������';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.STP_DAT IS '���� ����������� ���� �� �� � ����� �������';



PROMPT *** Create  constraint PK_CREDITS_DYN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_DYN ADD CONSTRAINT PK_CREDITS_DYN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CREDDYN_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_DYN MODIFY (PER_ID CONSTRAINT CC_CREDDYN_PERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CREDDYN_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_DYN MODIFY (ND CONSTRAINT CC_CREDDYN_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CREDDYN_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_DYN MODIFY (RNK CONSTRAINT CC_CREDDYN_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CREDDYN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_DYN MODIFY (KF CONSTRAINT CC_CREDDYN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CREDDYN_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_DYN MODIFY (BRANCH CONSTRAINT CC_CREDDYN_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CREDDYN_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_CREDDYN_PERID ON BARS_DM.CREDITS_DYN (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CREDITS_DYN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.PK_CREDITS_DYN ON BARS_DM.CREDITS_DYN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CREDITS_DYN ***
grant SELECT                                                                 on CREDITS_DYN     to BARS;
grant SELECT                                                                 on CREDITS_DYN     to BARSREADER_ROLE;
grant SELECT                                                                 on CREDITS_DYN     to BARSUPL;
grant SELECT                                                                 on CREDITS_DYN     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/CREDITS_DYN.sql =========*** End **
PROMPT ===================================================================================== 
