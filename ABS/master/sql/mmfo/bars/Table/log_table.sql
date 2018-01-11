

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LOG_TABLE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LOG_TABLE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LOG_TABLE'', ''CENTER'' , null, null, ''E'', ''E'');
               bpa.alter_policy_info(''LOG_TABLE'', ''FILIAL'' , null, null, ''E'', ''E'');
               bpa.alter_policy_info(''LOG_TABLE'', ''WHOLE'' , null, null, ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LOG_TABLE ***
begin 
  execute immediate '
  CREATE TABLE BARS.LOG_TABLE 
   (	ID NUMBER(38,0), 
	LOG_LEVEL VARCHAR2(10 CHAR), 
	PROCEDURE_NAME VARCHAR2(4000), 
	OBJECT_ID VARCHAR2(4000), 
	LOG_MESSAGE VARCHAR2(4000), 
	AUXILIARY_INFO CLOB, 
	CONTEXT_SNAPHOT VARCHAR2(4000), 
	USER_ID NUMBER(38,0), 
	SYS_TIME DATE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD 
 LOB (AUXILIARY_INFO) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
  PARTITION BY RANGE (SYS_TIME) INTERVAL (NUMTODSINTERVAL(1, ''DAY'')) 
 (PARTITION INITIAL_PARTITION  VALUES LESS THAN (TO_DATE('' 2017-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD 
 LOB (AUXILIARY_INFO) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LOG_TABLE ***
 exec bpa.alter_policies('LOG_TABLE');


COMMENT ON TABLE BARS.LOG_TABLE IS '';
COMMENT ON COLUMN BARS.LOG_TABLE.ID IS '';
COMMENT ON COLUMN BARS.LOG_TABLE.LOG_LEVEL IS '';
COMMENT ON COLUMN BARS.LOG_TABLE.PROCEDURE_NAME IS '';
COMMENT ON COLUMN BARS.LOG_TABLE.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.LOG_TABLE.LOG_MESSAGE IS '';
COMMENT ON COLUMN BARS.LOG_TABLE.AUXILIARY_INFO IS '';
COMMENT ON COLUMN BARS.LOG_TABLE.CONTEXT_SNAPHOT IS '';
COMMENT ON COLUMN BARS.LOG_TABLE.USER_ID IS '';
COMMENT ON COLUMN BARS.LOG_TABLE.SYS_TIME IS '';




PROMPT *** Create  constraint SYS_C00118483 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LOG_TABLE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118484 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LOG_TABLE MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_LOG_TABLE_OBJECT_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_LOG_TABLE_OBJECT_ID ON BARS.LOG_TABLE (OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 167 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION INITIAL_PARTITION 
  PCTFREE 10 INITRANS 2 MAXTRANS 167 LOGGING 
  TABLESPACE BRSBIGI ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_LOG_TABLE_LABEL ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_LOG_TABLE_LABEL ON BARS.LOG_TABLE (PROCEDURE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 167 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION INITIAL_PARTITION 
  PCTFREE 10 INITRANS 2 MAXTRANS 167 LOGGING 
  TABLESPACE BRSBIGI ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LOG_TABLE ***
grant SELECT                                                                 on LOG_TABLE       to BARSREADER_ROLE;
grant SELECT                                                                 on LOG_TABLE       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LOG_TABLE.sql =========*** End *** ===
PROMPT ===================================================================================== 
