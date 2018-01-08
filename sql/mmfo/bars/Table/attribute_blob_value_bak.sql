

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_BLOB_VALUE_BAK.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_BLOB_VALUE_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_BLOB_VALUE_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_BLOB_VALUE_BAK 
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




PROMPT *** ALTER_POLICIES to ATTRIBUTE_BLOB_VALUE_BAK ***
 exec bpa.alter_policies('ATTRIBUTE_BLOB_VALUE_BAK');


COMMENT ON TABLE BARS.ATTRIBUTE_BLOB_VALUE_BAK IS 'Значення атрибутів типу BLOB для збереження файлів та документів';
COMMENT ON COLUMN BARS.ATTRIBUTE_BLOB_VALUE_BAK.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_BLOB_VALUE_BAK.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_BLOB_VALUE_BAK.VALUE IS '';



PROMPT *** Create  grants  ATTRIBUTE_BLOB_VALUE_BAK ***
grant SELECT                                                                 on ATTRIBUTE_BLOB_VALUE_BAK to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_BLOB_VALUE_BAK.sql =========
PROMPT ===================================================================================== 
