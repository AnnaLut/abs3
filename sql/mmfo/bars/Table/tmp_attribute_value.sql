

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ATTRIBUTE_VALUE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ATTRIBUTE_VALUE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ATTRIBUTE_VALUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ATTRIBUTE_VALUE 
   (	ATTRIBUTE_ID NUMBER(5,0), 
	OBJECT_ID NUMBER(38,0), 
	VALUE_DATE DATE, 
	NUMBER_VALUE NUMBER, 
	STRING_VALUE VARCHAR2(4000), 
	DATE_VALUE DATE, 
	BLOB_VALUE BLOB, 
	CLOB_VALUE CLOB, 
	NESTED_TABLE_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (BLOB_VALUE) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (CLOB_VALUE) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ATTRIBUTE_VALUE ***
 exec bpa.alter_policies('TMP_ATTRIBUTE_VALUE');


COMMENT ON TABLE BARS.TMP_ATTRIBUTE_VALUE IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_VALUE.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_VALUE.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_VALUE.VALUE_DATE IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_VALUE.NUMBER_VALUE IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_VALUE.STRING_VALUE IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_VALUE.DATE_VALUE IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_VALUE.BLOB_VALUE IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_VALUE.CLOB_VALUE IS '';
COMMENT ON COLUMN BARS.TMP_ATTRIBUTE_VALUE.NESTED_TABLE_ID IS '';




PROMPT *** Create  constraint SYS_C00134192 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ATTRIBUTE_VALUE MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00134193 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ATTRIBUTE_VALUE MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ATTRIBUTE_VALUE ***
grant SELECT                                                                 on TMP_ATTRIBUTE_VALUE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ATTRIBUTE_VALUE.sql =========*** E
PROMPT ===================================================================================== 
