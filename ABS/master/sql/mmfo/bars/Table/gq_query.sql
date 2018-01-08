

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GQ_QUERY.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GQ_QUERY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GQ_QUERY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GQ_QUERY'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''GQ_QUERY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GQ_QUERY ***
begin 
  execute immediate '
  CREATE TABLE BARS.GQ_QUERY 
   (	QUERY_ID NUMBER(38,0), 
	QUERYTYPE_ID NUMBER(38,0), 
	QUERY_STATUS NUMBER(1,0), 
	REQUEST_DATE DATE, 
	REQUEST SYS.XMLTYPE , 
	RESPONSE_DATE DATE, 
	RESPONSE SYS.XMLTYPE , 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	USER_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 XMLTYPE COLUMN REQUEST STORE AS BASICFILE CLOB (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 XMLTYPE COLUMN RESPONSE STORE AS BASICFILE CLOB (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GQ_QUERY ***
 exec bpa.alter_policies('GQ_QUERY');


COMMENT ON TABLE BARS.GQ_QUERY IS 'Информационные запросы. Очередь запросов';
COMMENT ON COLUMN BARS.GQ_QUERY.QUERY_ID IS 'Идентификатор запроса';
COMMENT ON COLUMN BARS.GQ_QUERY.QUERYTYPE_ID IS 'Идентификатор типа запроса';
COMMENT ON COLUMN BARS.GQ_QUERY.QUERY_STATUS IS 'Статус запроса (0-создан, 1-обработан успешно, 2-обработан с ошибкой)';
COMMENT ON COLUMN BARS.GQ_QUERY.REQUEST_DATE IS 'Дата создания запроса';
COMMENT ON COLUMN BARS.GQ_QUERY.REQUEST IS '';
COMMENT ON COLUMN BARS.GQ_QUERY.RESPONSE_DATE IS '';
COMMENT ON COLUMN BARS.GQ_QUERY.RESPONSE IS '';
COMMENT ON COLUMN BARS.GQ_QUERY.BRANCH IS '';
COMMENT ON COLUMN BARS.GQ_QUERY.USER_ID IS '';




PROMPT *** Create  constraint PK_GQQUERY ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY ADD CONSTRAINT PK_GQQUERY PRIMARY KEY (QUERY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERY_QUERYSTATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY ADD CONSTRAINT CC_GQQUERY_QUERYSTATUS CHECK (query_status in (0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERY_REQUEST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY MODIFY (REQUEST CONSTRAINT CC_GQQUERY_REQUEST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERY_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY MODIFY (USER_ID CONSTRAINT CC_GQQUERY_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERY_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY MODIFY (BRANCH CONSTRAINT CC_GQQUERY_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERY_REQUESTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY MODIFY (REQUEST_DATE CONSTRAINT CC_GQQUERY_REQUESTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERY_QUERYSTATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY MODIFY (QUERY_STATUS CONSTRAINT CC_GQQUERY_QUERYSTATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERY_QUERYTYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY MODIFY (QUERYTYPE_ID CONSTRAINT CC_GQQUERY_QUERYTYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GQQUERY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY ADD CONSTRAINT FK_GQQUERY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GQQUERY_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY ADD CONSTRAINT FK_GQQUERY_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERY_QUERYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY MODIFY (QUERY_ID CONSTRAINT CC_GQQUERY_QUERYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GQQUERY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GQQUERY ON BARS.GQ_QUERY (QUERY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_GQQUERY ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_GQQUERY ON BARS.GQ_QUERY (DECODE(QUERY_STATUS,0,1,NULL)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GQ_QUERY ***
grant SELECT                                                                 on GQ_QUERY        to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GQ_QUERY        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GQ_QUERY.sql =========*** End *** ====
PROMPT ===================================================================================== 
