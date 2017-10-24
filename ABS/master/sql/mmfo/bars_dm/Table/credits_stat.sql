

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


COMMENT ON TABLE BARS_DM.CREDITS_STAT IS 'Кредити, статичні дані';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PAWN IS 'Вид застави/Поручительства';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.SDOG IS 'Сума кредиту (загальна сума договору)';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.TERM IS 'Строк кредиту (в місяцях)';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.VIDD_CUSTTYPE IS 'Тип клиента по виду договора: 3 - физическое лицо, 2 - юридическое лицо, 1 - банк';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.KV IS 'Валюта кредиту';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.POG_PLAN IS 'Планова сума погашення за минулий місяць';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.POG_FACT IS 'Фактична сума погашення за минулий місяць';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BORG_SY IS 'Сума залишку заборгованості на початок року, грн';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BORGPROC_SY IS 'Сума залишку заборгованості за відсотками на початок року, грн.';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BPK_NLS IS 'Рах.2625 для КД по БПК';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.INTRATE IS 'Розмір процентної ставки';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PTN_NAME IS 'найменування партнера';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.ID IS 'Ідентифікатор запису';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PER_ID IS 'Ідентифікатор періоду';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.ND IS 'Ідентифікатор КД';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.RNK IS 'РНК';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.KF IS 'МФО РУ';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.OKPO IS 'ІПН';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.CC_ID IS '№ договору';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.SDATE IS 'Дата укладання договору';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.WDATE IS 'Дата закінчення договору (фактична)';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.WDATE_FACT IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.VIDD IS 'Тип договору';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PROD IS 'Вид кредитного продукту';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PROD_CLAS IS 'Класифікація кредитного продукту';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PTN_OKPO IS 'код ЄДРПОУ партнера';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.PTN_MOTHER_NAME IS 'найменування материнської компанії';
COMMENT ON COLUMN BARS_DM.CREDITS_STAT.OPEN_DATE_BAL22 IS 'дата відкриття рахунку 2202/03 або 2232/33';
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
