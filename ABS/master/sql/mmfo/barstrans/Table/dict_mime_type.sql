

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/DICT_MIME_TYPES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table DICT_MIME_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.DICT_MIME_TYPES 
   (ID NUMBER, 
	MIME_TYPES VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.DICT_MIME_TYPES IS 'Довідник типів даних WEB';
COMMENT ON COLUMN BARSTRANS.DICT_MIME_TYPES.ID IS 'Ід';
COMMENT ON COLUMN BARSTRANS.DICT_MIME_TYPES.MIME_TYPES IS 'Назва типу даних';




PROMPT *** Create  constraint PK_DICT_MIME_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.DICT_MIME_TYPES ADD CONSTRAINT PK_DICT_MIME_TYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DICT_MIME_TYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_DICT_MIME_TYPES ON BARSTRANS.DICT_MIME_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/DICT_MIME_TYPES.sql =========*** 
PROMPT ===================================================================================== 

