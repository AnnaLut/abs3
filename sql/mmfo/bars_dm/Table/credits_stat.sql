

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/CREDITS_STAT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table CREDITS_STAT ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.CREDITS_STAT 
   (	ID NUMBER(15,0), 
	PER_ID NUMBER, 
	ND NUMBER(38,0), 
	RNK NUMBER(15,0), 
	KF VARCHAR2(12), 
	BRANCH VARCHAR2(30), 
	OKPO VARCHAR2(14), 
	CC_ID VARCHAR2(50), 
	SDATE DATE, 
	WDATE DATE, 
	WDATE_FACT DATE, 
	VIDD NUMBER(*,0), 
	PROD VARCHAR2(100), 
	PROD_CLAS VARCHAR2(100), 
	PAWN VARCHAR2(100), 
	SDOG NUMBER(24,2), 
	TERM NUMBER(*,0), 
	KV NUMBER(*,0), 
	POG_PLAN NUMBER(15,2), 
	POG_FACT NUMBER(15,2), 
	BORG_SY NUMBER(15,2), 
	BORGPROC_SY NUMBER(15,2), 
	BPK_NLS VARCHAR2(15), 
	INTRATE NUMBER, 
	PTN_NAME VARCHAR2(255), 
	PTN_OKPO VARCHAR2(14), 
	PTN_MOTHER_NAME VARCHAR2(255), 
	OPEN_DATE_BAL22 DATE, 
	ES000 VARCHAR2(24), 
	ES003 VARCHAR2(24), 
	VIDD_CUSTTYPE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.CREDITS_STAT IS '�������, ������� ���';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PAWN IS '��� �������/��������������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.SDOG IS '���� ������� (�������� ���� ��������)';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.TERM IS '����� ������� (� ������)';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.VIDD_CUSTTYPE IS '��� ������� �� ���� ��������: 3 - ���������� ����, 2 - ����������� ����, 1 - ����';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.KV IS '������ �������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.POG_PLAN IS '������� ���� ��������� �� ������� �����';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.POG_FACT IS '�������� ���� ��������� �� ������� �����';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BORG_SY IS '���� ������� ������������� �� ������� ����, ���';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BORGPROC_SY IS '���� ������� ������������� �� ��������� �� ������� ����, ���.';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BPK_NLS IS '���.2625 ��� �� �� ���';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.INTRATE IS '����� ��������� ������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PTN_NAME IS '������������ ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PER_ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.ND IS '������������� ��';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.RNK IS '���';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.KF IS '��� ��';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BRANCH IS '�����';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.OKPO IS '���';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.CC_ID IS '� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.SDATE IS '���� ��������� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.WDATE IS '���� ��������� �������� (��������)';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.WDATE_FACT IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.VIDD IS '��� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PROD IS '��� ���������� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PROD_CLAS IS '������������ ���������� ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PTN_OKPO IS '��� ������ ��������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PTN_MOTHER_NAME IS '������������ ����������� ������';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.OPEN_DATE_BAL22 IS '���� �������� ������� 2202/03 ��� 2232/33';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.ES000 IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.ES003 IS '';




PROMPT *** Create  constraint SYS_C00120076 ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_STAT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CREDITS_STAT ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_STAT ADD CONSTRAINT PK_CREDITS_STAT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CREDITS_PERID_PERIOD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_STAT ADD CONSTRAINT FK_CREDITS_PERID_PERIOD_ID FOREIGN KEY (PER_ID)
	  REFERENCES BARS_DM.PERIODS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CREDITS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_STAT ADD CONSTRAINT CC_CREDITS_BRANCH_NN CHECK (BRANCH IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CREDITS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_STAT ADD CONSTRAINT CC_CREDITS_KF_NN CHECK (KF IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CREDITS_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_STAT ADD CONSTRAINT CC_CREDITS_ND_NN CHECK (ND IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CREDITS_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_STAT ADD CONSTRAINT CC_CREDITS_PERID_NN CHECK (PER_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CREDITS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_STAT ADD CONSTRAINT CC_CREDITS_RNK_NN CHECK (RNK IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CREDITS_STAT_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_CREDITS_STAT_PERID ON BARS_DM.CREDITS_STAT (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CREDITS_STAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.PK_CREDITS_STAT ON BARS_DM.CREDITS_STAT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CREDITS_STAT ***
grant SELECT                                                                 on CREDITS_STAT    to BARS;
grant SELECT                                                                 on CREDITS_STAT    to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/CREDITS_STAT.sql =========*** End *
PROMPT ===================================================================================== 
