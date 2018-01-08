

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_RISK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_REZ_RISK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_RISK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_RISK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_RISK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_RISK 
   (	DAT DATE, 
	ID NUMBER(*,0), 
	S080 CHAR(1), 
	S080_NAME VARCHAR2(35), 
	CUSTTYPE NUMBER(*,0), 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(35), 
	KV NUMBER(*,0), 
	NLS VARCHAR2(15), 
	SK NUMBER, 
	SKQ NUMBER, 
	SOQ NUMBER, 
	SRQ NUMBER, 
	CC_ID VARCHAR2(20), 
	SZQ NUMBER, 
	SZ NUMBER, 
	SZ1 NUMBER, 
	FIN NUMBER(*,0), 
	OBS NUMBER(*,0), 
	IDR NUMBER(*,0), 
	RS080 CHAR(1), 
	COUNTRY NUMBER(*,0), 
	PR_REZ NUMBER, 
	RZ NUMBER DEFAULT 0, 
	ACC NUMBER(*,0), 
	ND NUMBER(*,0), 
	WDATE DATE, 
	KDATE DATE, 
	KPROLOG NUMBER, 
	SG NUMBER, 
	SV NUMBER, 
	PAWN NUMBER, 
	OBESP NUMBER, 
	DAT_PROL DATE, 
	METODIKA NUMBER, 
	ISP NUMBER, 
	OTD NUMBER, 
	FONDID NUMBER, 
	SN NUMBER, 
	TOBO VARCHAR2(22), 
	SKQ2 NUMBER, 
	DISCONT NUMBER, 
	SZQ2 NUMBER DEFAULT 0, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	CORP VARCHAR2(30), 
	PREM NUMBER, 
	ISTVAL VARCHAR2(1), 
	ODNCRE VARCHAR2(1), 
	DNIPR NUMBER, 
	REZOLDQ NUMBER DEFAULT 0, 
	DELREZQ NUMBER DEFAULT 0, 
	POGREZ NUMBER DEFAULT 0, 
	REZOLD NUMBER DEFAULT 0, 
	DELREZ NUMBER DEFAULT 0, 
	DELREZQCURS NUMBER DEFAULT 0, 
	FL_NEWACC VARCHAR2(1), 
	SZNQ NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_RISK ***
 exec bpa.alter_policies('TMP_REZ_RISK');


COMMENT ON TABLE BARS.TMP_REZ_RISK IS 'таблица по расчету резерва';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DAT IS 'дата расчета';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ID IS 'код пользователя запустившего расчет';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.S080 IS 'категория риска - код';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.S080_NAME IS 'категория риска - наименование';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.CUSTTYPE IS 'тип клиента - владельца счета актива, для банка Киев физики и юрики имеют один код = 2';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.RNK IS 'рег номер клиента владельца счета актива';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.NMK IS 'наименование контрагента';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.KV IS 'валюта актива';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.NLS IS 'лицевой счет актива';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SK IS 'остаток номинал на счете актива с учетам ЗО на отчетную дату';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SKQ IS 'остаток эквивалент на счете актива с учетам ЗО на отчетную дату';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SOQ IS 'приведенное обеспечение';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SRQ IS 'чистый кредитный риск = остаток на счете кредита принятый в расчет - дисконт - приведенное обеспечение';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.CC_ID IS 'номер кредитного договора';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SZQ IS 'резерв эквивалент';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SZ IS 'резерв номинал';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SZ1 IS 'поле для ввода произвольной суммы резерва по счету';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.FIN IS 'финансовое состояние контрагента';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.OBS IS 'состояние обслуживания долга';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.IDR IS 'код вида резерва';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.RS080 IS 'расчетная категория риска';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.COUNTRY IS 'страна контрагента';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.PR_REZ IS 'процент резервирования';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.RZ IS 'резидентность';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ACC IS 'acc счета актива';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ND IS 'номер кредитного договра';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.WDATE IS 'начальная дата договра';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.KDATE IS 'конечная дата договора';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.KPROLOG IS 'количество пролонгаций';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SG IS 'начальная сумма кредитного договора в гривне';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SV IS 'начальная сумма кредитного договора в валюте';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.PAWN IS 'вид обеспечения для нескольких видов обеспечения = 40';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.OBESP IS 'приведенное обеспечение на кредит без учета процента от залога';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DAT_PROL IS 'дата последней пролонгации';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.METODIKA IS 'не используется';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ISP IS 'отв исполнитель по счету';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.OTD IS 'отдел отв исполнителя';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.FONDID IS 'не используется';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SN IS 'признак актива - стандартный/нестандартный';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.TOBO IS 'ТОБО';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SKQ2 IS 'остаток на счете кредита принятый в расчет, для 9129 = 50% и т.п.';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DISCONT IS 'приведенный дисконт эквивалент';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SZQ2 IS 'резерв эквивалент без учета дисконта';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.CORP IS 'признак корпоративного клиента';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.PREM IS 'премия';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ISTVAL IS 'признак наличие источника валютной выручки';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ODNCRE IS 'признак однородного кредита';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DNIPR IS 'дни просрочки однородного кредита';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.REZOLDQ IS 'резерв предыдущего периода (эквивалент на отчетную дату)';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DELREZQ IS 'приращение резерва эквивалент';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.POGREZ IS 'погашено актива за счет резерва номинал';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.REZOLD IS 'предыдущий резерв в номинале';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DELREZ IS 'приращение в резерве номинал';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DELREZQCURS IS 'приращение резерва в эквивалене связанное с изменением валютных курсов';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.FL_NEWACC IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SZNQ IS '';




PROMPT *** Create  constraint FK_REZ_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_RISK ADD CONSTRAINT FK_REZ_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZ_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_RISK MODIFY (BRANCH CONSTRAINT CC_REZ_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMP_REZ_RISK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_RISK ADD CONSTRAINT PK_TMP_REZ_RISK PRIMARY KEY (ID, DAT, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_REZ_RISK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_REZ_RISK ON BARS.TMP_REZ_RISK (ID, DAT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_SZ1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_SZ1 ON BARS.TMP_REZ_RISK (SZ1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REZ_RISK ***
grant SELECT                                                                 on TMP_REZ_RISK    to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_RISK    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REZ_RISK    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_RISK    to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_REZ_RISK    to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_REZ_RISK ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_REZ_RISK FOR BARS.TMP_REZ_RISK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISK.sql =========*** End *** 
PROMPT ===================================================================================== 
