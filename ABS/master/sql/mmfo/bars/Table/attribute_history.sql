

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_HISTORY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_HISTORY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ATTRIBUTE_HISTORY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ATTRIBUTE_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_HISTORY 
   (	ID NUMBER(38,0), 
	ATTRIBUTE_ID NUMBER(5,0), 
	OBJECT_ID NUMBER(38,0), 
	VALID_FROM DATE, 
	VALID_THROUGH DATE, 
	NUMBER_VALUE NUMBER, 
	STRING_VALUE VARCHAR2(4000), 
	DATE_VALUE DATE, 
	BLOB_VALUE BLOB, 
	CLOB_VALUE CLOB, 
	NESTED_TABLE_ID NUMBER(38,0), 
	STATE_CODE CHAR(1), 
	USER_ID NUMBER(38,0), 
	SYS_TIME DATE, 
	COMMENT_TEXT VARCHAR2(4000)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD 
 LOB (BLOB_VALUE) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (CLOB_VALUE) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
  PARTITION BY RANGE (ID) INTERVAL (2000000) 
 (PARTITION INITIAL_PARTITION  VALUES LESS THAN (0) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD 
 LOB (BLOB_VALUE) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (CLOB_VALUE) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_HISTORY ***
 exec bpa.alter_policies('ATTRIBUTE_HISTORY');


COMMENT ON TABLE BARS.ATTRIBUTE_HISTORY IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.VALID_FROM IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.VALID_THROUGH IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.NUMBER_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.STRING_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.DATE_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.BLOB_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.CLOB_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.NESTED_TABLE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.STATE_CODE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.USER_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.SYS_TIME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.COMMENT_TEXT IS '';




PROMPT *** Create  constraint SYS_C0025685 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025686 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025687 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025688 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY MODIFY (STATE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025689 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025690 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_HISTORY ***
grant SELECT                                                                 on ATTRIBUTE_HISTORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ATTRIBUTE_HISTORY to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_HISTORY.sql =========*** End
PROMPT ===================================================================================== 
