

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_ADD_AGREEMENTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_ADD_AGREEMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_ADD_AGREEMENTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_ADD_AGREEMENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_ADD_AGREEMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_ADD_AGREEMENTS 
   (	ID NUMBER, 
	DEAL_ID NUMBER, 
	BRANCH VARCHAR2(30), 
	STAFF_ID NUMBER, 
	CRT_DATE DATE, 
	SER VARCHAR2(100), 
	NUM VARCHAR2(100), 
	SDATE DATE, 
	CHANGES XMLTYPE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 XMLTYPE COLUMN CHANGES STORE AS SECUREFILE BINARY XML (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_ADD_AGREEMENTS ***
 exec bpa.alter_policies('INS_ADD_AGREEMENTS');


COMMENT ON TABLE BARS.INS_ADD_AGREEMENTS IS 'Дод. угоди до страхових договорів';
COMMENT ON COLUMN BARS.INS_ADD_AGREEMENTS.KF IS '';
COMMENT ON COLUMN BARS.INS_ADD_AGREEMENTS.CHANGES IS 'Перелік змін';
COMMENT ON COLUMN BARS.INS_ADD_AGREEMENTS.SDATE IS 'Дата початку дії ДУ';
COMMENT ON COLUMN BARS.INS_ADD_AGREEMENTS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_ADD_AGREEMENTS.DEAL_ID IS 'Ідентифікатор СД';
COMMENT ON COLUMN BARS.INS_ADD_AGREEMENTS.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.INS_ADD_AGREEMENTS.STAFF_ID IS 'Код менеджера';
COMMENT ON COLUMN BARS.INS_ADD_AGREEMENTS.CRT_DATE IS 'Дата створення';
COMMENT ON COLUMN BARS.INS_ADD_AGREEMENTS.SER IS 'Серія ДУ';
COMMENT ON COLUMN BARS.INS_ADD_AGREEMENTS.NUM IS 'Номер ДУ';




PROMPT *** Create  constraint CC_INSADDAGRS_CRTD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ADD_AGREEMENTS MODIFY (CRT_DATE CONSTRAINT CC_INSADDAGRS_CRTD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSADDAGRS_NUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ADD_AGREEMENTS MODIFY (NUM CONSTRAINT CC_INSADDAGRS_NUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSADDAGRS_SDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ADD_AGREEMENTS MODIFY (SDATE CONSTRAINT CC_INSADDAGRS_SDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSADDAGRS_CHGS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ADD_AGREEMENTS MODIFY (CHANGES CONSTRAINT CC_INSADDAGRS_CHGS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSADDAGRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ADD_AGREEMENTS ADD CONSTRAINT PK_INSADDAGRS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_INSADDAGRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ADD_AGREEMENTS ADD CONSTRAINT UK_INSADDAGRS UNIQUE (DEAL_ID, SER, NUM, SDATE, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033425 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ADD_AGREEMENTS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSADDAGRS_DID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ADD_AGREEMENTS MODIFY (DEAL_ID CONSTRAINT CC_INSADDAGRS_DID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSADDAGRS_BRCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ADD_AGREEMENTS MODIFY (BRANCH CONSTRAINT CC_INSADDAGRS_BRCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSADDAGRS_SID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ADD_AGREEMENTS MODIFY (STAFF_ID CONSTRAINT CC_INSADDAGRS_SID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSADDAGRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSADDAGRS ON BARS.INS_ADD_AGREEMENTS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_INSADDAGRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_INSADDAGRS ON BARS.INS_ADD_AGREEMENTS (DEAL_ID, SER, NUM, SDATE, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_ADD_AGREEMENTS ***
grant SELECT                                                                 on INS_ADD_AGREEMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on INS_ADD_AGREEMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_ADD_AGREEMENTS.sql =========*** En
PROMPT ===================================================================================== 
