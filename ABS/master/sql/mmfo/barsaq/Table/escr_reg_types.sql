

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_TYPES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_REG_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_REG_TYPES 
   (	ID NUMBER, 
	CODE VARCHAR2(100), 
	NAME VARCHAR2(250)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_REG_TYPES IS 'Таблиця типів реєстрів';
COMMENT ON COLUMN BARSAQ.ESCR_REG_TYPES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARSAQ.ESCR_REG_TYPES.CODE IS 'Код типу';
COMMENT ON COLUMN BARSAQ.ESCR_REG_TYPES.NAME IS 'Найменування типу';




PROMPT *** Create  constraint PK_REG_TYPE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_TYPES ADD CONSTRAINT PK_REG_TYPE_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REG_TYPE_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_REG_TYPE_ID ON BARSAQ.ESCR_REG_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_TYPES.sql =========*** End 
PROMPT ===================================================================================== 
