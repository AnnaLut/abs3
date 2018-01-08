

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
	VIDD_CUSTTYPE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.CREDITS_DYN IS 'Кредити, динамічні дані';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.ES000 IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.ES003 IS '';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.VIDD_CUSTTYPE IS 'Тип клиента по виду договора: 3 - физическое лицо, 2 - юридическое лицо, 1 - банк';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.ID IS 'Ідентифікатор запису';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PER_ID IS 'Ідентифікатор періоду';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.ND IS 'Ідентифікатор КД';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.RNK IS 'РНК';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.KF IS 'МФО РУ';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.CC_ID IS '№ договору';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.SDATE IS 'Дата укладання договору';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.VIDD IS 'Тип договору';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.NEXT_PAY IS 'Дата здійснення наступного платежу';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROBL_ROZGL IS 'На стадії розгляду питання про визнання проблемним ';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROBL_DATE IS 'Дата визнання кредиту проблемним';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROBL IS 'Визнання кредиту проблемним';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.CRED_CHANGE IS 'Зміна умов кредитування ';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.CRED_DATECHANGE IS 'Дата здійснення зміни умов кредитування';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG IS 'Сума заборгованості за кредитом у валюті кредиту';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_TILO IS 'Сума заборгованості за тілом кредиту у валюті кредиту';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_PROC IS 'Сума заборгованості за відсотками у валюті кредиту';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROSR1 IS 'Дата виникнення першої прострочки за кредитом';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROSR2 IS 'Дата виникнення другої прострочки за кредитом';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROSRCNT IS 'Кількість прострочених платежів';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_PROSR IS 'Сума простроченої заборгованості за кредитом у валюті кредиту';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_TILO_PROSR IS 'Сума простроченої заборгованості за тілом у валюті кредиту';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_PROC_PROSR IS 'Сума простроченої заборгованості за процентами у валюті кредиту';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PENJA IS 'Сума пені у валюті кредиту';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.SHTRAF IS 'Сума нарахованих штрафів у валюті кредиту';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PAY_TILO IS 'Сума повернутих коштів по кредиту в поточному році, грн';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PAY_PROC IS 'Сума повернутих процентів за кредитом в поточному році, грн';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.CAT_RYZYK IS 'Категорія ризику кредитної операції';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.CRED_TO_PROSR IS 'Дата віднесення кредиту на рахунок простроченої заборгованості';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_TO_PBAL IS 'Дата перенесення заборгованості на позабалансові рахунки';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.VART_MAJNA IS 'Вартість прийнятого майна на баланс, грн ';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.POG_FINISH IS 'Чинна дата погашення кредиту згідно з останніми змінами';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROSR_FACT_CNT IS 'Кількість фактів виходу на просрочку';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.NEXT_PAY_ALL IS 'Сума наступного платежу, всього';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.NEXT_PAY_TILO IS 'Сума наступного платежу, тіло';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.NEXT_PAY_PROC IS 'Сума наступного платежу, відсотки';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.SOS IS 'Стан договору';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.LAST_PAY_DATE IS 'Дата останього платежу';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.LAST_PAY_SUMA IS 'Сума останього платежу';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROSRCNT_PROC IS 'Кількість прострочених непогашених платежів по відсотках';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.TILO_PROSR_UAH IS 'Сума простроченої заборгованості за тілом у гривні';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PROC_PROSR_UAH IS 'Сума простроченої заборгованості за відсотками у гривні';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_TILO_UAH IS 'Сума заборгованості за тілом у гривні';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.BORG_PROC_UAH IS 'Сума заборгованості за відсотками у гривні';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.PAY_VDVS IS 'Всього перераховано коштів від ВДВС, грн.';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.AMOUNT_COMMISSION IS 'Сума комісії за КД у валюті кредиту';
COMMENT ON COLUMN BARS_DM.CREDITS_DYN.AMOUNT_PROSR_COMMISSION IS 'Сума простроченої комісії за КД у валюті кредиту';




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




PROMPT *** Create  constraint FK_CREDDYN_PERID_PERIOD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.CREDITS_DYN ADD CONSTRAINT FK_CREDDYN_PERID_PERIOD_ID FOREIGN KEY (PER_ID)
	  REFERENCES BARS_DM.PERIODS (ID) DISABLE';
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
grant SELECT                                                                 on CREDITS_DYN     to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/CREDITS_DYN.sql =========*** End **
PROMPT ===================================================================================== 
