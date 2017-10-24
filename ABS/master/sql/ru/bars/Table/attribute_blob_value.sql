

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_BLOB_VALUE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_BLOB_VALUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_BLOB_VALUE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ATTRIBUTE_BLOB_VALUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_BLOB_VALUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_BLOB_VALUE 
   (	OBJECT_ID NUMBER(12,0), 
	ATTRIBUTE_ID NUMBER(5,0), 
	VALUE BLOB
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSDYND 
 LOB (VALUE) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
  PARTITION BY RANGE (ATTRIBUTE_ID) INTERVAL (1) 
 (PARTITION INITIAL_PARTITION  VALUES LESS THAN (1) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSDYND 
 LOB (VALUE) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_BLOB_VALUE ***
 exec bpa.alter_policies('ATTRIBUTE_BLOB_VALUE');


COMMENT ON TABLE BARS.ATTRIBUTE_BLOB_VALUE IS 'Значення атрибутів типу BLOB для збереження файлів та документів';
COMMENT ON COLUMN BARS.ATTRIBUTE_BLOB_VALUE.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_BLOB_VALUE.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_BLOB_VALUE.VALUE IS '';




PROMPT *** Create  constraint FK_BLOB_VAL_REF_ATTR_KIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_BLOB_VALUE ADD CONSTRAINT FK_BLOB_VAL_REF_ATTR_KIND FOREIGN KEY (ATTRIBUTE_ID)
	  REFERENCES BARS.ATTRIBUTE_KIND (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861344 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_BLOB_VALUE MODIFY (VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861343 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_BLOB_VALUE MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861342 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_BLOB_VALUE MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OBJ_BLOB_ATTR_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.OBJ_BLOB_ATTR_IDX ON BARS.ATTRIBUTE_BLOB_VALUE (OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_BLOB_VALUE.sql =========*** 
PROMPT ===================================================================================== 
