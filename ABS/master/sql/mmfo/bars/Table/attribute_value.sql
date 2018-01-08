

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

declare
    index_already_exists exception;
    pragma exception_init(index_already_exists, -955);
begin
    execute immediate 'create unique index bars.ui_attribute_value on bars.attribute_value (attribute_id, object_id) tablespace brsbigi compress 1 local';
exception
    when index_already_exists then
         null;
end;
/

declare
    index_already_exists exception;
    pragma exception_init(index_already_exists, -955);
begin
    execute immediate 'create index bars.i_attribute_number_value on bars.attribute_value (number_value) tablespace brsbigi compress 1 local';
exception
    when index_already_exists then
         null;
end;
/

declare
    index_already_exists exception;
    pragma exception_init(index_already_exists, -955);
begin
    execute immediate 'create index bars.i_attribute_string_value on bars.attribute_value (string_value) tablespace brsbigi compress 1 local';
exception
    when index_already_exists then
         null;
end;
/

declare
    index_already_exists exception;
    pragma exception_init(index_already_exists, -955);
begin
    execute immediate 'create index bars.i_attribute_date_value on bars.attribute_value (date_value) tablespace brsbigi compress 1 local';
exception
    when index_already_exists then
         null;
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




PROMPT *** Create  constraint SYS_C0025698 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_VALUE MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025697 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_VALUE MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_VALUE ***
grant SELECT                                                                 on ATTRIBUTE_VALUE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_VALUE.sql =========*** End *
PROMPT ===================================================================================== 
