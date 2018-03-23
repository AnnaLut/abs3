PROMPT *** Create  table DEPOSITS ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.DEPOSITS 
  (	PER_ID NUMBER, 
  DEPOSIT_ID NUMBER, 
  BRANCH VARCHAR2(30), 
  KF VARCHAR2(12), 
  RNK NUMBER(38,0), 
  ND VARCHAR2(35), 
  DAT_BEGIN DATE, 
  DAT_END DATE, 
  NLS VARCHAR2(15), 
  VIDD NUMBER(38,0), 
  TERM NUMBER(*,0), 
  SDOG NUMBER, 
  MASSA NUMBER, 
  KV NUMBER(3,0), 
  INTRATE NUMBER, 
  SDOG_BEGIN NUMBER, 
  LAST_ADD_DATE DATE, 
  LAST_ADD_SUMA NUMBER, 
  OSTC NUMBER, 
  SUMA_PROC NUMBER, 
  SUMA_PROC_PLAN NUMBER, 
  DPT_STATUS NUMBER(1,0), 
  SUMA_PROC_PAYOFF NUMBER, 
  DATE_PROC_PAYOFF DATE, 
  DATE_DEP_PAYOFF DATE, 
  DATZ DATE, 
  DAZS DATE, 
  BLKD NUMBER(3,0), 
  BLKK NUMBER(3,0), 
  CNT_DUBL NUMBER, 
  ARCHDOC_ID NUMBER,
  WB CHAR(1),
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
    execute immediate q'[alter table bars_dm.deposits add ob22 varchar2(2)]';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/
begin
    execute immediate q'[alter table bars_dm.deposits add nms varchar2(70)]';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/

COMMENT ON TABLE BARS_DM.DEPOSITS IS 'Депозити';
COMMENT ON COLUMN BARS_DM.DEPOSITS.CNT_DUBL IS 'Кількість пролонгацій';
COMMENT ON COLUMN BARS_DM.DEPOSITS.ARCHDOC_ID IS 'Ідентифікатор депозитного договору в ЕАД';
COMMENT ON COLUMN BARS_DM.DEPOSITS.BLKD IS 'Код блокування рахунку по дебету';
COMMENT ON COLUMN BARS_DM.DEPOSITS.BLKK IS 'Код блокування рахунку по кредиту';
COMMENT ON COLUMN BARS_DM.DEPOSITS.SUMA_PROC_PAYOFF IS 'Сума виплачених відсотків';
COMMENT ON COLUMN BARS_DM.DEPOSITS.DATE_PROC_PAYOFF IS 'Дата виплати відсотків (остання)';
COMMENT ON COLUMN BARS_DM.DEPOSITS.DATE_DEP_PAYOFF IS 'Дата виплати депозиту';
COMMENT ON COLUMN BARS_DM.DEPOSITS.DAZS IS 'Дата закриття рахунку';
COMMENT ON COLUMN BARS_DM.DEPOSITS.DATZ IS 'Дата заключення вкладу';
COMMENT ON COLUMN BARS_DM.DEPOSITS.DPT_STATUS IS 'Статус деп..договору 0-відкритий, 1-закритий, 2-закритий достроково';
COMMENT ON COLUMN BARS_DM.DEPOSITS.PER_ID IS 'Ідентифікатор періоду';
COMMENT ON COLUMN BARS_DM.DEPOSITS.DEPOSIT_ID IS '';
COMMENT ON COLUMN BARS_DM.DEPOSITS.BRANCH IS 'Відділення';
COMMENT ON COLUMN BARS_DM.DEPOSITS.KF IS 'МФО РУ';
COMMENT ON COLUMN BARS_DM.DEPOSITS.RNK IS 'РНК';
COMMENT ON COLUMN BARS_DM.DEPOSITS.ND IS '№ договору';
COMMENT ON COLUMN BARS_DM.DEPOSITS.DAT_BEGIN IS 'Договір від';
COMMENT ON COLUMN BARS_DM.DEPOSITS.DAT_END IS 'Дата закінчення договору';
COMMENT ON COLUMN BARS_DM.DEPOSITS.NLS IS '№ рахунку';
COMMENT ON COLUMN BARS_DM.DEPOSITS.VIDD IS 'Тип договору';
COMMENT ON COLUMN BARS_DM.DEPOSITS.TERM IS 'Строк вкладу';
COMMENT ON COLUMN BARS_DM.DEPOSITS.SDOG IS 'Сума вкладу';
COMMENT ON COLUMN BARS_DM.DEPOSITS.MASSA IS 'Маса вкладу (для деп. в банк.металах)';
COMMENT ON COLUMN BARS_DM.DEPOSITS.KV IS 'Валюта вкладу';
COMMENT ON COLUMN BARS_DM.DEPOSITS.INTRATE IS 'Відсоткова ставка';
COMMENT ON COLUMN BARS_DM.DEPOSITS.SDOG_BEGIN IS 'Початкова сума вкладу';
COMMENT ON COLUMN BARS_DM.DEPOSITS.LAST_ADD_DATE IS 'Дата останього поповнення';
COMMENT ON COLUMN BARS_DM.DEPOSITS.LAST_ADD_SUMA IS 'Сума останього поповнення';
COMMENT ON COLUMN BARS_DM.DEPOSITS.OSTC IS 'Поточний залишок';
COMMENT ON COLUMN BARS_DM.DEPOSITS.SUMA_PROC IS 'Поточна сума нарахованих відсотків';
COMMENT ON COLUMN BARS_DM.DEPOSITS.SUMA_PROC_PLAN IS 'Сума відсотків на планову дату виплати';


PROMPT *** ADD COLUMN WB ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DEPOSITS ADD WB CHAR(1)';
exception when others then
  if  sqlcode=-1430 then null; else raise; end if;
 end;
/

COMMENT ON COLUMN BARS_DM.DEPOSITS.WB IS 'Депозит открыт в веб-банкинге';


PROMPT *** Create  constraint FK_DEPOSITS_PERID_PERIOD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DEPOSITS ADD CONSTRAINT FK_DEPOSITS_PERID_PERIOD_ID FOREIGN KEY (PER_ID)
	  REFERENCES BARS_DM.PERIODS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_DEPOSITS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DEPOSITS MODIFY (RNK CONSTRAINT CC_DEPOSITS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_DEPOSITS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DEPOSITS MODIFY (KF CONSTRAINT CC_DEPOSITS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_DEPOSITS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DEPOSITS MODIFY (BRANCH CONSTRAINT CC_DEPOSITS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_DEPOSITS_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DEPOSITS MODIFY (PER_ID CONSTRAINT CC_DEPOSITS_PERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  index I_DEPOSITS_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_DEPOSITS_PERID ON BARS_DM.DEPOSITS (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  DEPOSITS ***
grant SELECT                                                                 on DEPOSITS        to BARS;
grant SELECT                                                                 on DEPOSITS        to BARSUPL;
grant SELECT                                                                 on DEPOSITS        to BARS_SUP;