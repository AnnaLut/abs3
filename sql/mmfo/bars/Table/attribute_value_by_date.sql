

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_VALUE_BY_DATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_VALUE_BY_DATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_VALUE_BY_DATE'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_VALUE_BY_DATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_VALUE_BY_DATE 
   (	ATTRIBUTE_ID NUMBER(5,0), 
	OBJECT_ID NUMBER(38,0), 
	VALUE_DATE DATE, 
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




PROMPT *** ALTER_POLICIES to ATTRIBUTE_VALUE_BY_DATE ***
 exec bpa.alter_policies('ATTRIBUTE_VALUE_BY_DATE');


COMMENT ON TABLE BARS.ATTRIBUTE_VALUE_BY_DATE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE_BY_DATE.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE_BY_DATE.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE_BY_DATE.VALUE_DATE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE_BY_DATE.NUMBER_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE_BY_DATE.STRING_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE_BY_DATE.DATE_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE_BY_DATE.BLOB_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE_BY_DATE.CLOB_VALUE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUE_BY_DATE.NESTED_TABLE_ID IS '';




PROMPT *** Create  constraint SYS_C0025695 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_VALUE_BY_DATE MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025694 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_VALUE_BY_DATE MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index ATTR_VAL_BYD_OBJECT_IDX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.ATTR_VAL_BYD_OBJECT_IDX ON BARS.ATTRIBUTE_VALUE_BY_DATE (ATTRIBUTE_ID, OBJECT_ID, VALUE_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION DEFAULT_PARTITION 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) COMPRESS 1 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ATTR_VAL_BYD_NUMBER_VAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ATTR_VAL_BYD_NUMBER_VAL ON BARS.ATTRIBUTE_VALUE_BY_DATE (NUMBER_VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ATTR_VAL_BYD_STRING_VAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ATTR_VAL_BYD_STRING_VAL ON BARS.ATTRIBUTE_VALUE_BY_DATE (STRING_VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 167 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ATTR_VAL_BYD_DATE_VAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ATTR_VAL_BYD_DATE_VAL ON BARS.ATTRIBUTE_VALUE_BY_DATE (DATE_VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ATTR_VAL_BYD_NESTED_TAB ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ATTR_VAL_BYD_NESTED_TAB ON BARS.ATTRIBUTE_VALUE_BY_DATE (NESTED_TABLE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_VALUE_BY_DATE ***
grant SELECT                                                                 on ATTRIBUTE_VALUE_BY_DATE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_VALUE_BY_DATE.sql =========*
PROMPT ===================================================================================== 
