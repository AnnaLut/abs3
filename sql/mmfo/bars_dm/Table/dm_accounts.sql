PROMPT *** Create  table DM_ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.DM_ACCOUNTS 
   (PER_ID NUMBER, 
	ACC NUMBER, 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(12), 
	RNK NUMBER(38,0), 
	NLS VARCHAR2(15), 
	VIDD VARCHAR2(10), 
	DAOS DATE, 
	KV NUMBER(3,0), 
	INTRATE NUMBER, 
	MASSA NUMBER, 
	COUNT_ZL NUMBER, 
	OSTC NUMBER, 
	OB_MON NUMBER, 
	LAST_ADD_DATE DATE, 
	LAST_ADD_SUMA NUMBER, 
	DAZS DATE, 
	ACC_STATUS NUMBER(1,0), 
	BLKD NUMBER(3,0), 
	BLKK NUMBER(3,0),
	ob22 varchar2(2),
	nms varchar2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
prompt add ob22, nms
begin
    execute immediate q'[alter table bars_dm.dm_accounts add ob22 varchar2(2)]';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/
begin
    execute immediate q'[alter table bars_dm.dm_accounts add nms varchar2(70)]';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/

COMMENT ON TABLE BARS_DM.DM_ACCOUNTS IS '������ �������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.PER_ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.ACC IS '';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.BRANCH IS '³�������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.KF IS '��� ��';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.RNK IS '���';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.NLS IS '� �������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.VIDD IS '��� ������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.DAOS IS '���� �������� �������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.KV IS '������ �������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.INTRATE IS '³�������� ������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.MASSA IS '���� ������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.COUNT_ZL IS 'ʳ������ ������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.OSTC IS '�������� �������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.OB_MON IS '������� �� ������� �� �����';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.LAST_ADD_DATE IS '���� ��������� ����������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.LAST_ADD_SUMA IS '���� ��������� ����������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.DAZS IS '���� �������� �������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.ACC_STATUS IS '������ ������� (1-��������, 0-��������)';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.BLKD IS '��� ���������� ������� �� ������';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.BLKK IS '��� ���������� ������� �� �������';

PROMPT *** Create  constraint CC_ACCOUNTS_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DM_ACCOUNTS MODIFY (PER_ID CONSTRAINT CC_ACCOUNTS_PERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_ACCOUNTS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DM_ACCOUNTS MODIFY (ACC CONSTRAINT CC_ACCOUNTS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_ACCOUNTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DM_ACCOUNTS MODIFY (BRANCH CONSTRAINT CC_ACCOUNTS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_ACCOUNTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DM_ACCOUNTS MODIFY (KF CONSTRAINT CC_ACCOUNTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_ACCOUNTS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DM_ACCOUNTS MODIFY (RNK CONSTRAINT CC_ACCOUNTS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index I_ACCOUNTS_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_ACCOUNTS_PERID ON BARS_DM.DM_ACCOUNTS (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  DM_ACCOUNTS ***
grant SELECT                                                                 on DM_ACCOUNTS     to BARS;
grant SELECT                                                                 on DM_ACCOUNTS     to BARSREADER_ROLE;
grant SELECT                                                                 on DM_ACCOUNTS     to BARSUPL;
grant SELECT                                                                 on DM_ACCOUNTS     to UPLD;