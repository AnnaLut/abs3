

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_SMALL_VALUE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_SMALL_VALUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_SMALL_VALUE'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_SMALL_VALUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_SMALL_VALUE 
   (	ATTRIBUTE_ID NUMBER(5,0), 
	OBJECT_ID NUMBER(38,0), 
	NUMBER_VALUE NUMBER, 
	STRING_VALUE VARCHAR2(4000), 
	DATE_VALUE DATE, 
	BLOB_VALUE BLOB, 
	CLOB_VALUE CLOB, 
	NESTED_TABLE_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGI 
 LOB (BLOB_VALUE) STORE AS BASICFILE (
  TABLESPACE BRSBIGI ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (CLOB_VALUE) STORE AS BASICFILE (
  TABLESPACE BRSBIGI ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_SMALL_VALUE ***
 exec bpa.alter_policies('ATTRIBUTE_SMALL_VALUE');


COMMENT ON TABLE BARS.ATTRIBUTE_SMALL_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_SMALL_VALUE.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_SMALL_VALUE.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_SMALL_VALUE.NUMBER_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_SMALL_VALUE.STRING_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_SMALL_VALUE.DATE_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_SMALL_VALUE.BLOB_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_SMALL_VALUE.CLOB_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_SMALL_VALUE.NESTED_TABLE_ID IS '';




PROMPT *** Create  constraint PK_ATTRIBUTE_SMALL_VALUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_SMALL_VALUE ADD CONSTRAINT PK_ATTRIBUTE_SMALL_VALUE PRIMARY KEY (ATTRIBUTE_ID, OBJECT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025691 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_SMALL_VALUE MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025692 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_SMALL_VALUE MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_SMALL_VALUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ATTRIBUTE_SMALL_VALUE ON BARS.ATTRIBUTE_SMALL_VALUE (ATTRIBUTE_ID, OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_SMALL_VALUE ***
grant SELECT                                                                 on ATTRIBUTE_SMALL_VALUE to BARSREADER_ROLE;
grant SELECT                                                                 on ATTRIBUTE_SMALL_VALUE to BARS_DM;
grant SELECT                                                                 on ATTRIBUTE_SMALL_VALUE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_SMALL_VALUE.sql =========***
PROMPT ===================================================================================== 
