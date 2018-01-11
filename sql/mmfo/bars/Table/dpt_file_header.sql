

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_FILE_HEADER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_FILE_HEADER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_FILE_HEADER'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_FILE_HEADER'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_FILE_HEADER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_FILE_HEADER ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_FILE_HEADER 
   (	FILENAME VARCHAR2(16), 
	HEADER_LENGTH NUMBER(3,0), 
	DAT DATE, 
	INFO_LENGTH NUMBER(6,0), 
	MFO_A VARCHAR2(15), 
	NLS_A VARCHAR2(15), 
	MFO_B VARCHAR2(15), 
	NLS_B VARCHAR2(15), 
	DK NUMBER(1,0), 
	SUM NUMBER(19,0), 
	TYPE NUMBER(2,0), 
	NUM VARCHAR2(12), 
	HAS_ADD VARCHAR2(1), 
	NAME_A VARCHAR2(27), 
	NAME_B VARCHAR2(27), 
	NAZN VARCHAR2(160), 
	BRANCH_CODE NUMBER(5,0), 
	DPT_CODE NUMBER(3,0), 
	EXEC_ORD VARCHAR2(10), 
	KS_EP VARCHAR2(32), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	TYPE_ID NUMBER(38,0), 
	HEADER_ID NUMBER(38,0), 
	AGENCY_TYPE NUMBER(38,0), 
	FILE_VERSION VARCHAR2(1) DEFAULT ''1'', 
	RECHECK_AGENCY NUMBER(1,0) DEFAULT 1, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	USR_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_FILE_HEADER ***
 exec bpa.alter_policies('DPT_FILE_HEADER');


COMMENT ON TABLE BARS.DPT_FILE_HEADER IS 'Структура заголовку файла обміну';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.USR_ID IS '';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.FILENAME IS 'Найменування файлу';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.HEADER_LENGTH IS 'Довжина заголовка';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.DAT IS 'Дата створення файлу';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.INFO_LENGTH IS 'Кiлькiсть iнформацiйних рядкiв';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.MFO_A IS 'МФО банку-платника';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.NLS_A IS 'Рахунок платника';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.MFO_B IS 'МФО банку-одержувача';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.NLS_B IS 'Рахунок одержувача';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.DK IS 'Ознака "дебет/кредит" платежу';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.SUM IS 'Сума (в коп.) платежу';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.TYPE IS 'Вид платежу';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.NUM IS 'Номер (операцiйний) платежу';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.HAS_ADD IS 'Ознака наявностi додатку до платежу';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.NAME_A IS 'Найменування платника';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.NAME_B IS 'Найменування одержувача';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.BRANCH_CODE IS 'Номер філії';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.DPT_CODE IS 'Код вкладу';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.EXEC_ORD IS 'Режими обробки';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.KS_EP IS 'КС або ЕП';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.BRANCH IS 'Код подразделения (МФО)';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.TYPE_ID IS 'ID типа';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.HEADER_ID IS '';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.AGENCY_TYPE IS '';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.FILE_VERSION IS 'Чи потрібно перепроставляти код органа соц. захисту при зміні відділення: 1 - так, 0 - ні';
COMMENT ON COLUMN BARS.DPT_FILE_HEADER.RECHECK_AGENCY IS '';




PROMPT *** Create  constraint PK_DPTFILEHEADER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER ADD CONSTRAINT PK_DPTFILEHEADER PRIMARY KEY (HEADER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (KF CONSTRAINT CC_DPTFILEHDR_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHEADER_USRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (USR_ID CONSTRAINT CC_DPTFILEHEADER_USRID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (FILENAME CONSTRAINT CC_DPTFILEHDR_FILENAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_HDRLEN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (HEADER_LENGTH CONSTRAINT CC_DPTFILEHDR_HDRLEN_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (DAT CONSTRAINT CC_DPTFILEHDR_DAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_MFOA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (MFO_A CONSTRAINT CC_DPTFILEHDR_MFOA_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (NLS_A CONSTRAINT CC_DPTFILEHDR_NLSA_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_MFOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (MFO_B CONSTRAINT CC_DPTFILEHDR_MFOB_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_NLSB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (NLS_B CONSTRAINT CC_DPTFILEHDR_NLSB_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (DK CONSTRAINT CC_DPTFILEHDR_DK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (TYPE CONSTRAINT CC_DPTFILEHDR_TYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_NAMEA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (NAME_A CONSTRAINT CC_DPTFILEHDR_NAMEA_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_NAMEB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (NAME_B CONSTRAINT CC_DPTFILEHDR_NAMEB_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_DPTCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (DPT_CODE CONSTRAINT CC_DPTFILEHDR_DPTCODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (BRANCH CONSTRAINT CC_DPTFILEHDR_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHDR_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (TYPE_ID CONSTRAINT CC_DPTFILEHDR_TYPEID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILEHEADER_HEADERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER MODIFY (HEADER_ID CONSTRAINT CC_DPTFILEHEADER_HEADERID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTFILEHEADER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTFILEHEADER ON BARS.DPT_FILE_HEADER (HEADER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index DPTFILEHDR_BRANCH ***
begin   
 execute immediate '
  CREATE INDEX BARS.DPTFILEHDR_BRANCH ON BARS.DPT_FILE_HEADER (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTFILEHEADER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTFILEHEADER ON BARS.DPT_FILE_HEADER (KF, HEADER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index DPTFILEHDR_KF_DAT_TPID_USRID ***
begin   
 execute immediate '
  CREATE INDEX BARS.DPTFILEHDR_KF_DAT_TPID_USRID ON BARS.DPT_FILE_HEADER (KF, DAT, TYPE_ID, USR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_FILE_HEADER ***
grant SELECT                                                                 on DPT_FILE_HEADER to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on DPT_FILE_HEADER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_FILE_HEADER to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on DPT_FILE_HEADER to DPT_ROLE;
grant SELECT                                                                 on DPT_FILE_HEADER to RPBN001;
grant SELECT                                                                 on DPT_FILE_HEADER to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_FILE_HEADER to WR_ALL_RIGHTS;
grant SELECT                                                                 on DPT_FILE_HEADER to WR_CBIREP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_FILE_HEADER.sql =========*** End *
PROMPT ===================================================================================== 
