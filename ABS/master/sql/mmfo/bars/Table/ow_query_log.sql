

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_QUERY_LOG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_QUERY_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_QUERY_LOG'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_QUERY_LOG'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_QUERY_LOG'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_QUERY_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_QUERY_LOG 
   (	REQID NUMBER(38,0), 
	RNK NUMBER(38,0), 
	ND NUMBER(22,0), 
	REQUESTDATE DATE DEFAULT sysdate, 
	RESPCODE NUMBER(5,0), 
	RESPTEXT VARCHAR2(4000), 
	REQBODY CLOB, 
	ERR_TEXT VARCHAR2(4000), 
	RESPBODY CLOB, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (REQBODY) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (RESPBODY) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_QUERY_LOG ***
 exec bpa.alter_policies('OW_QUERY_LOG');


COMMENT ON TABLE BARS.OW_QUERY_LOG IS 'Журнал отправки запросов на Way4';
COMMENT ON COLUMN BARS.OW_QUERY_LOG.RESPBODY IS 'Тіло відповіді';
COMMENT ON COLUMN BARS.OW_QUERY_LOG.KF IS '';
COMMENT ON COLUMN BARS.OW_QUERY_LOG.REQID IS '';
COMMENT ON COLUMN BARS.OW_QUERY_LOG.RNK IS '';
COMMENT ON COLUMN BARS.OW_QUERY_LOG.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.OW_QUERY_LOG.REQUESTDATE IS 'Дата запиту';
COMMENT ON COLUMN BARS.OW_QUERY_LOG.RESPCODE IS 'Код відповіді';
COMMENT ON COLUMN BARS.OW_QUERY_LOG.RESPTEXT IS 'Тест відповіді';
COMMENT ON COLUMN BARS.OW_QUERY_LOG.REQBODY IS 'Тіло запиту';
COMMENT ON COLUMN BARS.OW_QUERY_LOG.ERR_TEXT IS '';




PROMPT *** Create  constraint SYS_C0010538 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_QUERY_LOG MODIFY (REQID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010539 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_QUERY_LOG MODIFY (RNK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010540 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_QUERY_LOG MODIFY (ND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010541 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_QUERY_LOG MODIFY (REQUESTDATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
    execute immediate 'create index I_OWQUERYLOG_REQID on OW_QUERY_LOG (reqid)
  tablespace BRSDYNI';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index I_OW_QUERY_LOG_ND on OW_QUERY_LOG (nd)
  tablespace BRSDYNI';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


PROMPT *** Create  grants  OW_QUERY_LOG ***
grant SELECT                                                                 on OW_QUERY_LOG    to BARSREADER_ROLE;
grant SELECT                                                                 on OW_QUERY_LOG    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_QUERY_LOG.sql =========*** End *** 
PROMPT ===================================================================================== 
