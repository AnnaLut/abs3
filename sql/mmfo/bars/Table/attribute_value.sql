

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_VALUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_VALUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_VALUE'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_VALUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_VALUE 
   (	ATTRIBUTE_ID NUMBER(5,0), 
	OBJECT_ID NUMBER(38,0), 
	NUMBER_VALUE NUMBER, 
	STRING_VALUE VARCHAR2(4000), 
	DATE_VALUE DATE, 
	BLOB_VALUE BLOB, 
	CLOB_VALUE CLOB, 
	NESTED_TABLE_ID NUMBER(38,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD 
 LOB (BLOB_VALUE) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (CLOB_VALUE) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
  PARTITION BY RANGE (ATTRIBUTE_ID) INTERVAL (1) 
 (PARTITION DEFAULT_PARTITION  VALUES LESS THAN (0) SEGMENT CREATION IMMEDIATE 
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




PROMPT *** ALTER_POLICIES to ATTRIBUTE_VALUE ***
 exec bpa.alter_policies('ATTRIBUTE_VALUE');


COMMENT ON TABLE BARS.ATTRIBUTE_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE.NUMBER_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE.STRING_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE.DATE_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE.BLOB_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE.CLOB_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE.NESTED_TABLE_ID IS '';




PROMPT *** Create  constraint SYS_C0025697 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_VALUE MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025698 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_VALUE MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UI_ATTRIBUTE_VALUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UI_ATTRIBUTE_VALUE ON BARS.ATTRIBUTE_VALUE (ATTRIBUTE_ID, OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION DEFAULT_PARTITION 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) COMPRESS 1 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ATTRIBUTE_NUMBER_VALUE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ATTRIBUTE_NUMBER_VALUE ON BARS.ATTRIBUTE_VALUE (NUMBER_VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION DEFAULT_PARTITION 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) COMPRESS 1 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ATTRIBUTE_STRING_VALUE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ATTRIBUTE_STRING_VALUE ON BARS.ATTRIBUTE_VALUE (STRING_VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 167 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION DEFAULT_PARTITION 
  PCTFREE 10 INITRANS 2 MAXTRANS 167 LOGGING 
  TABLESPACE BRSBIGI ) COMPRESS 1 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ATTRIBUTE_DATE_VALUE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ATTRIBUTE_DATE_VALUE ON BARS.ATTRIBUTE_VALUE (DATE_VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION DEFAULT_PARTITION 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) COMPRESS 1 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_VALUE ***
grant SELECT                                                                 on ATTRIBUTE_VALUE to BARSREADER_ROLE;
grant SELECT                                                                 on ATTRIBUTE_VALUE to BARS_DM;
grant SELECT                                                                 on ATTRIBUTE_VALUE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_VALUE.sql =========*** End *
PROMPT ===================================================================================== 
