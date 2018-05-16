

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_DEAL_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_DEAL_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_DEAL_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_DEAL_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_DEAL_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_DEAL_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_DEAL_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ND NUMBER(38,0), 
	SOS NUMBER(*,0), 
	CC_ID VARCHAR2(50), 
	SDATE DATE, 
	WDATE DATE, 
	RNK NUMBER(*,0), 
	VIDD NUMBER(*,0), 
	LIMIT NUMBER(24,4), 
	KPROLOG NUMBER(*,0), 
	USER_ID NUMBER(*,0), 
	OBS NUMBER(*,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6), 
	IR NUMBER, 
	PROD VARCHAR2(100), 
	SDOG NUMBER(24,2), 
	SKARB_ID VARCHAR2(50), 
	FIN NUMBER(*,0), 
	NDI NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	KOL_SP NUMBER, 
	S250 VARCHAR2(1), 
	GRP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Add column NDG ***
begin   
 execute immediate 'ALTER TABLE BARS.CC_DEAL_UPDATE add NDG NUMBER';
exception when others then
  if  sqlcode=-01430 or sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** ALTER_POLICIES to CC_DEAL_UPDATE ***
 exec bpa.alter_policies('CC_DEAL_UPDATE');


COMMENT ON TABLE BARS.CC_DEAL_UPDATE IS 'История изменений договоров';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.IDUPD IS 'Первичный ключ для таблицы обновления';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.CHGACTION IS 'Код обновления (I/U/D)';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.EFFECTDATE IS 'Банковская дата начала действия параметров';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.CHGDATE IS 'Системаная дата обновления';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.DONEBY IS 'Код пользователя. кто внес обновления(если в течении дня было несколько обновлений - остается только последнее)';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.ND IS 'Номер договора (референц)';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.SOS IS 'СОСТОЯНИЕ договора';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.CC_ID IS 'Идентификатор договора';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.SDATE IS 'Дата заключения договора';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.WDATE IS 'Дата завершения';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.RNK IS 'Номер клиента';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.VIDD IS 'Вид договора';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.LIMIT IS 'Лимит договора';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.KPROLOG IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.USER_ID IS 'Исполнитель';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.OBS IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.BRANCH IS 'Бранч(ТОБО)-эмитент КД';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.IR IS 'Ст.бр для VIDD=26 или Эт.ЭС для 1,2,3,11,12,13';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.PROD IS 'Код продукта';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.SDOG IS 'Начальная сумма 100.55 - в цел с коп';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.SKARB_ID IS '';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.FIN IS 'Клас позичальника (фин.стан)';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.NDI IS 'Код первоначального реф договора (связанные договора)';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.FIN23 IS 'ФiнКлас по НБУ-23';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.OBS23 IS 'Обсл.долга по НБУ-23';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.KAT23 IS 'Категорiя якостi за кредитом по НБУ-23';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.K23 IS 'Коеф.Показник ризику по НБУ-23';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.KOL_SP IS 'К-во дней просрочки по договору';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.S250 IS 'Портфельный метод (8)';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.GRP IS 'група активу портфельного методу';
COMMENT ON COLUMN BARS.CC_DEAL_UPDATE.NDG IS 'Реф генерального КД';



PROMPT *** Create  constraint SYS_C009611 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (ND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009612 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (SOS NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009613 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (RNK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009614 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (VIDD NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009615 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (USER_ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009616 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (BRANCH NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009617 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CCDEAL_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DEAL_UPDATE ADD CONSTRAINT PK_CCDEAL_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCDEAL_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCDEAL_UPDATE ON BARS.CC_DEAL_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCDEAL_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCDEAL_UPDATEEFFDAT ON BARS.CC_DEAL_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCDEAL_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCDEAL_UPDATEPK ON BARS.CC_DEAL_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_DEAL_UPDATE ***
grant SELECT                                                                 on CC_DEAL_UPDATE  to BARSREADER_ROLE;
grant SELECT                                                                 on CC_DEAL_UPDATE  to BARSUPL;
grant SELECT                                                                 on CC_DEAL_UPDATE  to BARS_DM;
grant SELECT                                                                 on CC_DEAL_UPDATE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_DEAL_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
