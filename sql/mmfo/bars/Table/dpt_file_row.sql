

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_FILE_ROW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_FILE_ROW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_FILE_ROW'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_FILE_ROW'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_FILE_ROW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_FILE_ROW ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_FILE_ROW 
   (	INFO_ID NUMBER(18,0), 
	FILENAME VARCHAR2(16), 
	DAT DATE, 
	NLS VARCHAR2(19), 
	BRANCH_CODE NUMBER(5,0), 
	DPT_CODE NUMBER(3,0), 
	SUM NUMBER(19,0), 
	FIO VARCHAR2(100), 
	PASP VARCHAR2(16), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	REF NUMBER(38,0), 
	INCORRECT NUMBER(1,0) DEFAULT 0, 
	CLOSED NUMBER(1,0) DEFAULT 0, 
	EXCLUDED NUMBER(1,0) DEFAULT 0, 
	HEADER_ID NUMBER(38,0), 
	AGENCY_ID NUMBER(38,0), 
	AGENCY_NAME VARCHAR2(100), 
	ID_CODE VARCHAR2(10), 
	FILE_PAYOFF_DATE VARCHAR2(2), 
	PAYOFF_DATE DATE, 
	MARKED4PAYMENT NUMBER(1,0) DEFAULT 0, 
	DEAL_CREATED NUMBER(1,0) DEFAULT 0, 
	ACC_TYPE CHAR(3), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ERR_MSG VARCHAR2(256)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_FILE_ROW ***
 exec bpa.alter_policies('DPT_FILE_ROW');


COMMENT ON TABLE BARS.DPT_FILE_ROW IS 'Структура тела файла зачисления пенсий и мат.помощи';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.ERR_MSG IS 'Повідомлення про помилку';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.INFO_ID IS 'Код рядка';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.FILENAME IS 'Найменування файлу';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.DAT IS 'Дата створення файлу';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.NLS IS 'Номер рахунку вкладника';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.BRANCH_CODE IS 'Номер філії';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.DPT_CODE IS 'Код вкладу';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.SUM IS 'Сума (в коп.)';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.FIO IS 'Прiзвище,iм`я, по батьковi';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.PASP IS 'Серiя та номер паспорта';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.BRANCH IS 'Філія';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.REF IS 'Референс породженого документа';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.INCORRECT IS '0 - коректный; 1 - некоректный';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.CLOSED IS '0 - діючий; 1 - закритий';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.EXCLUDED IS '0 - не исключенный; 1 - исключенный';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.HEADER_ID IS '';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.AGENCY_ID IS '';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.AGENCY_NAME IS '';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.ID_CODE IS 'Ідентифікаційний код (для перевірок НЕ використовується)';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.FILE_PAYOFF_DATE IS 'Дата проплати з файла (2 символи)';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.PAYOFF_DATE IS 'Дата проплати фактична';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.MARKED4PAYMENT IS 'Відмічений до оплати ( 0 - ні, 1 - так)';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.DEAL_CREATED IS 'Ознака того, що при прийомі стрічки було створеного нового клієнта та новий договір (1 - так, 0 - ні)';
COMMENT ON COLUMN BARS.DPT_FILE_ROW.ACC_TYPE IS '';




PROMPT *** Create  constraint CK_DPTFILEROW_DEALCREATED ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW ADD CONSTRAINT CK_DPTFILEROW_DEALCREATED CHECK (deal_created in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTFILEROW ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW ADD CONSTRAINT PK_DPTFILEROW PRIMARY KEY (INFO_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CK_DPTFILEROW_MARKED4PAYMENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW ADD CONSTRAINT CK_DPTFILEROW_MARKED4PAYMENT CHECK (marked4payment in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROW_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (KF CONSTRAINT CC_DPTFILEROW_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROW_EXCLUDED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (EXCLUDED CONSTRAINT CC_DPTFILEROW_EXCLUDED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006131 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (MARKED4PAYMENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_DPTFILEROW_DEALCREATED ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (DEAL_CREATED CONSTRAINT NN_DPTFILEROW_DEALCREATED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROW_INFOID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (INFO_ID CONSTRAINT CC_DPTFILEROW_INFOID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROW_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (FILENAME CONSTRAINT CC_DPTFILEROW_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROW_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (DAT CONSTRAINT CC_DPTFILEROW_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006123 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006124 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (BRANCH_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006125 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (DPT_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006126 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (FIO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROW_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (BRANCH CONSTRAINT CC_DPTFILEROW_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROW_INCORRECT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (INCORRECT CONSTRAINT CC_DPTFILEROW_INCORRECT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEROW_CLOSED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW MODIFY (CLOSED CONSTRAINT CC_DPTFILEROW_CLOSED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPTFILEROW_HDRID_KF ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPTFILEROW_HDRID_KF ON BARS.DPT_FILE_ROW (HEADER_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTFILEROW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTFILEROW ON BARS.DPT_FILE_ROW (INFO_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTFILEROW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTFILEROW ON BARS.DPT_FILE_ROW (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_FILE_ROW ***
grant SELECT                                                                 on DPT_FILE_ROW    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_FILE_ROW    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_FILE_ROW    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_FILE_ROW    to DPT_ROLE;
grant SELECT                                                                 on DPT_FILE_ROW    to RPBN001;
grant SELECT                                                                 on DPT_FILE_ROW    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_FILE_ROW    to WR_ALL_RIGHTS;
grant SELECT                                                                 on DPT_FILE_ROW    to WR_CBIREP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_FILE_ROW.sql =========*** End *** 
PROMPT ===================================================================================== 
