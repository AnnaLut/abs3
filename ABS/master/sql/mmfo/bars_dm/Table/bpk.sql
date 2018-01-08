

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/BPK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  table BPK ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.BPK 
   (	PER_ID NUMBER, 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(12), 
	RNK NUMBER(38,0), 
	ND NUMBER, 
	DAT_BEGIN DATE, 
	BPK_TYPE VARCHAR2(32), 
	NLS VARCHAR2(15), 
	DAOS DATE, 
	KV NUMBER(3,0), 
	INTRATE NUMBER, 
	OSTC NUMBER, 
	DATE_LASTOP DATE, 
	CRED_LINE VARCHAR2(20), 
	CRED_LIM NUMBER, 
	USE_CRED_SUM NUMBER, 
	DAZS DATE, 
	BLKD NUMBER(3,0), 
	BLKK NUMBER(3,0), 
	BPK_STATUS NUMBER(1,0), 
	PK_OKPO VARCHAR2(10), 
	PK_NAME VARCHAR2(100), 
	PK_OKPO_N NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.BPK IS '������ ������';
COMMENT ON COLUMN BARS_DM.BPK.DATE_LASTOP IS '���� ������� ��������';
COMMENT ON COLUMN BARS_DM.BPK.CRED_LINE IS '';
COMMENT ON COLUMN BARS_DM.BPK.CRED_LIM IS '';
COMMENT ON COLUMN BARS_DM.BPK.USE_CRED_SUM IS '';
COMMENT ON COLUMN BARS_DM.BPK.DAZS IS '���� �������� �������';
COMMENT ON COLUMN BARS_DM.BPK.BLKD IS '��� ���������� ������� �� ������';
COMMENT ON COLUMN BARS_DM.BPK.BLKK IS '��� ���������� ������� �� �������';
COMMENT ON COLUMN BARS_DM.BPK.BPK_STATUS IS '������ �������� �� �������(1-��������, 0-��������)';
COMMENT ON COLUMN BARS_DM.BPK.PK_OKPO IS '���������� ������, ������ ����������';
COMMENT ON COLUMN BARS_DM.BPK.PK_NAME IS '���������� ������, ����� ����������';
COMMENT ON COLUMN BARS_DM.BPK.PK_OKPO_N IS '���������� ������, ��� �������� ����������';
COMMENT ON COLUMN BARS_DM.BPK.PER_ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.BPK.BRANCH IS '³�������';
COMMENT ON COLUMN BARS_DM.BPK.KF IS '��� ��';
COMMENT ON COLUMN BARS_DM.BPK.RNK IS '���';
COMMENT ON COLUMN BARS_DM.BPK.ND IS '����� ��������';
COMMENT ON COLUMN BARS_DM.BPK.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS_DM.BPK.BPK_TYPE IS '';
COMMENT ON COLUMN BARS_DM.BPK.NLS IS '� �������';
COMMENT ON COLUMN BARS_DM.BPK.DAOS IS '���� �������� �������';
COMMENT ON COLUMN BARS_DM.BPK.KV IS '������ �������';
COMMENT ON COLUMN BARS_DM.BPK.INTRATE IS '³�������� ������';
COMMENT ON COLUMN BARS_DM.BPK.OSTC IS '�������� �������';




PROMPT *** Create  constraint FK_BPK_PERID_PERIOD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK ADD CONSTRAINT FK_BPK_PERID_PERIOD_ID FOREIGN KEY (PER_ID)
	  REFERENCES BARS_DM.PERIODS (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPK_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK MODIFY (PER_ID CONSTRAINT CC_BPK_PERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPK_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK MODIFY (BRANCH CONSTRAINT CC_BPK_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK MODIFY (KF CONSTRAINT CC_BPK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPK_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BPK MODIFY (RNK CONSTRAINT CC_BPK_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_BPK_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_BPK_PERID ON BARS_DM.BPK (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK ***
grant SELECT                                                                 on BPK             to BARS;
grant SELECT                                                                 on BPK             to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/BPK.sql =========*** End *** ======
PROMPT ===================================================================================== 
