

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_REQUESTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_REQUESTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_REQUESTS'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_REQUESTS'', ''FILIAL'' , null, ''M'', null, ''M'');
               bpa.alter_policy_info(''DPT_REQUESTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_REQUESTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_REQUESTS 
   (	REQ_ID NUMBER(38,0), 
	REQTYPE_ID NUMBER(38,0), 
	REQ_BDATE DATE, 
	REQ_CRDATE DATE, 
	REQ_CRUSERID NUMBER(38,0), 
	REQ_PRCDATE DATE, 
	REQ_PRCUSERID NUMBER(38,0), 
	REQ_STATE NUMBER(1,0), 
	DPT_ID NUMBER(38,0), 
	OTM NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_REQUESTS ***
 exec bpa.alter_policies('DPT_REQUESTS');


COMMENT ON TABLE BARS.DPT_REQUESTS IS 'Депозитные договора. Запросы';
COMMENT ON COLUMN BARS.DPT_REQUESTS.REQ_ID IS 'Идентификатор запроса';
COMMENT ON COLUMN BARS.DPT_REQUESTS.REQTYPE_ID IS 'Идентификатор типа запроса';
COMMENT ON COLUMN BARS.DPT_REQUESTS.REQ_BDATE IS 'Банковская дата запроса';
COMMENT ON COLUMN BARS.DPT_REQUESTS.REQ_CRDATE IS 'Дата формирования запроса';
COMMENT ON COLUMN BARS.DPT_REQUESTS.REQ_CRUSERID IS 'Идентификатор пользователя, который сформировал запрос';
COMMENT ON COLUMN BARS.DPT_REQUESTS.REQ_PRCDATE IS 'Дата обработки запроса';
COMMENT ON COLUMN BARS.DPT_REQUESTS.REQ_PRCUSERID IS 'Идентификатор пользователя, который обработал запрос';
COMMENT ON COLUMN BARS.DPT_REQUESTS.REQ_STATE IS 'Состояние запроса';
COMMENT ON COLUMN BARS.DPT_REQUESTS.DPT_ID IS 'Идентификатор договора, по кот. выполняется запрос';
COMMENT ON COLUMN BARS.DPT_REQUESTS.OTM IS '';
COMMENT ON COLUMN BARS.DPT_REQUESTS.KF IS '';
COMMENT ON COLUMN BARS.DPT_REQUESTS.BRANCH IS '';




PROMPT *** Create  constraint PK_DPTREQS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS ADD CONSTRAINT PK_DPTREQS PRIMARY KEY (REQ_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQS_REQSTATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS ADD CONSTRAINT CC_DPTREQS_REQSTATE CHECK (req_state in (-1, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTREQS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS ADD CONSTRAINT UK_DPTREQS UNIQUE (KF, REQ_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQS_REQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS MODIFY (REQ_ID CONSTRAINT CC_DPTREQS_REQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQS_REQTYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS MODIFY (REQTYPE_ID CONSTRAINT CC_DPTREQS_REQTYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQS_REQBDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS MODIFY (REQ_BDATE CONSTRAINT CC_DPTREQS_REQBDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQS_REQCRDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS MODIFY (REQ_CRDATE CONSTRAINT CC_DPTREQS_REQCRDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQS_REQCRUSERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS MODIFY (REQ_CRUSERID CONSTRAINT CC_DPTREQS_REQCRUSERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQS_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS MODIFY (DPT_ID CONSTRAINT CC_DPTREQS_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS MODIFY (KF CONSTRAINT CC_DPTREQS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTREQS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REQUESTS MODIFY (BRANCH CONSTRAINT CC_DPTREQS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DPTREQS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DPTREQS ON BARS.DPT_REQUESTS (DECODE(TO_CHAR(REQ_STATE),NULL,1,NULL)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTREQS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTREQS ON BARS.DPT_REQUESTS (REQ_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTREQS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTREQS ON BARS.DPT_REQUESTS (KF, REQ_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_REQUESTS ***
grant SELECT                                                                 on DPT_REQUESTS    to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_REQUESTS    to BARS_DM;
grant SELECT                                                                 on DPT_REQUESTS    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_REQUESTS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_REQUESTS.sql =========*** End *** 
PROMPT ===================================================================================== 
