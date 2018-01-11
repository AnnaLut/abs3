

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/ATTRIBUTE_KIND.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table ATTRIBUTE_KIND ***
begin 
  execute immediate '
  CREATE TABLE CDB.ATTRIBUTE_KIND 
   (	ID NUMBER(5,0), 
	ATTRIBUTE_NAME VARCHAR2(300 CHAR), 
	VALUE_TYPE NUMBER(2,0), 
	FIELD_NAME VARCHAR2(30 CHAR), 
	IS_DELETE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.ATTRIBUTE_KIND IS '';
COMMENT ON COLUMN CDB.ATTRIBUTE_KIND.ID IS 'Ідентифікатор виду атрибутів';
COMMENT ON COLUMN CDB.ATTRIBUTE_KIND.ATTRIBUTE_NAME IS 'Назва виду атрибутів';
COMMENT ON COLUMN CDB.ATTRIBUTE_KIND.VALUE_TYPE IS 'Тип значення атрибуту (число, дата, строка та ін.)';
COMMENT ON COLUMN CDB.ATTRIBUTE_KIND.FIELD_NAME IS 'Поле, в якому зберігається поточне значення атрибута';
COMMENT ON COLUMN CDB.ATTRIBUTE_KIND.IS_DELETE IS 'Вид атрибуту не активний?';




PROMPT *** Create  constraint PK_ATTRIBUTE_KIND ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_KIND ADD CONSTRAINT PK_ATTRIBUTE_KIND PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118886 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_KIND MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118887 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_KIND MODIFY (ATTRIBUTE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118888 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_KIND MODIFY (VALUE_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118889 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_KIND MODIFY (FIELD_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118890 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_KIND MODIFY (IS_DELETE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_KIND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_ATTRIBUTE_KIND ON CDB.ATTRIBUTE_KIND (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_KIND ***
grant SELECT                                                                 on ATTRIBUTE_KIND  to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/ATTRIBUTE_KIND.sql =========*** End ***
PROMPT ===================================================================================== 
