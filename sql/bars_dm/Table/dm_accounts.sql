PROMPT *** Create  table DM_ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.DM_ACCOUNTS 
   (	PER_ID NUMBER, 
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

COMMENT ON TABLE BARS_DM.DM_ACCOUNTS IS 'Поточні рахунки';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.DAOS IS 'Дата відкриття рахунку';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.KV IS 'Валюта рахунку';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.INTRATE IS 'Відсоткова ставка';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.MASSA IS 'Вага злитку';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.COUNT_ZL IS 'Кількість злитків';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.OSTC IS 'Поточний залишок';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.OB_MON IS 'Обороти по рахунку за місяць';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.LAST_ADD_DATE IS 'Дата останього поповнення';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.LAST_ADD_SUMA IS 'Сума останього поповнення';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.DAZS IS 'Дата закриття рахунку';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.ACC_STATUS IS 'Статус рахунку (1-відкритий, 0-закритий)';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.BLKD IS 'Код блокування рахунку по дебету';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.BLKK IS 'Код блокування рахунку по кредиту';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.PER_ID IS 'Ідентифікатор періоду';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.ACC IS '';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.BRANCH IS 'Відділення';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.KF IS 'МФО РУ';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.RNK IS 'РНК';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.NLS IS '№ рахунку';
COMMENT ON COLUMN BARS_DM.DM_ACCOUNTS.VIDD IS 'Вид вкладу';

PROMPT *** Create  constraint FK_ACCOUNTS_PERID_PERIOD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DM_ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_PERID_PERIOD_ID FOREIGN KEY (PER_ID)
	  REFERENCES BARS_DM.PERIODS (ID) ENABLE';
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

PROMPT *** Create  constraint CC_ACCOUNTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DM_ACCOUNTS MODIFY (KF CONSTRAINT CC_ACCOUNTS_KF_NN NOT NULL ENABLE)';
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

PROMPT *** Create  constraint CC_ACCOUNTS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DM_ACCOUNTS MODIFY (ACC CONSTRAINT CC_ACCOUNTS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_ACCOUNTS_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DM_ACCOUNTS MODIFY (PER_ID CONSTRAINT CC_ACCOUNTS_PERID_NN NOT NULL ENABLE)';
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
grant SELECT                                                                 on DM_ACCOUNTS     to BARSUPL;
grant SELECT                                                                 on DM_ACCOUNTS     to BARS_SUP;