

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REGISTER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_REGISTER ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_REGISTER 
   (	USER_ID NUMBER, 
	STATUS_ID NUMBER, 
	REG_UNION_FLAG NUMBER, 
	ID NUMBER, 
	INNER_NUMBER VARCHAR2(250), 
	OUTER_NUMBER VARCHAR2(250), 
	CREATE_DATE DATE DEFAULT sysdate, 
	DATE_FROM DATE, 
	DATE_TO DATE, 
	REG_TYPE_ID NUMBER, 
	REG_KIND_ID NUMBER, 
	REG_LEVEL NUMBER, 
	BRANCH VARCHAR2(30), 
	USER_NAME VARCHAR2(400), 
	FILE_ID NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_REGISTER IS 'Список реєстрів по енергокредитам';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.USER_ID IS 'Користувач,який створив реєстр ID';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.STATUS_ID IS 'Поточний статус';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.REG_UNION_FLAG IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.INNER_NUMBER IS 'Внутрішній номер ';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.OUTER_NUMBER IS 'Зовнішній номер';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.CREATE_DATE IS 'Дата створення';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.DATE_FROM IS 'Дата з ';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.DATE_TO IS 'Дата по';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.REG_TYPE_ID IS 'Типу реєстру';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.REG_KIND_ID IS 'Вид реєстру';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.REG_LEVEL IS '1-ЦА,0-РУ';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.USER_NAME IS 'Користувач,який створив реєстр ПІБ';
COMMENT ON COLUMN BARSAQ.ESCR_REGISTER.FILE_ID IS 'ID файлу, з якого було сформовано реєстр (для ЦБД)';




PROMPT *** Create  constraint PK_REG_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REGISTER ADD CONSTRAINT PK_REG_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REGISTER_INNER_NUMBER ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REGISTER ADD CONSTRAINT CC_ESCR_REGISTER_INNER_NUMBER CHECK (INNER_NUMBER IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REGISTER_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REGISTER ADD CONSTRAINT CC_ESCR_REGISTER_ID CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REG_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_REG_ID ON BARSAQ.ESCR_REGISTER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REGISTER.sql =========*** End *
PROMPT ===================================================================================== 
