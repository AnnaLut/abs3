

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_REGISTER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_REGISTER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_REGISTER'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ESCR_REGISTER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_REGISTER ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_REGISTER 
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
	FILE_ID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_REGISTER ***
 exec bpa.alter_policies('ESCR_REGISTER');


COMMENT ON TABLE BARS.ESCR_REGISTER IS 'Список реєстрів по енергокредитам';
COMMENT ON COLUMN BARS.ESCR_REGISTER.USER_ID IS 'Користувач,який створив реєстр ID';
COMMENT ON COLUMN BARS.ESCR_REGISTER.STATUS_ID IS 'Поточний статус';
COMMENT ON COLUMN BARS.ESCR_REGISTER.REG_UNION_FLAG IS 'Ознака реєстр об'єднаний чи ні 1-так,0-ні';
COMMENT ON COLUMN BARS.ESCR_REGISTER.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.ESCR_REGISTER.INNER_NUMBER IS 'Внутрішній номер ';
COMMENT ON COLUMN BARS.ESCR_REGISTER.OUTER_NUMBER IS 'Зовнішній номер';
COMMENT ON COLUMN BARS.ESCR_REGISTER.CREATE_DATE IS 'Дата створення';
COMMENT ON COLUMN BARS.ESCR_REGISTER.DATE_FROM IS 'Дата з ';
COMMENT ON COLUMN BARS.ESCR_REGISTER.DATE_TO IS 'Дата по';
COMMENT ON COLUMN BARS.ESCR_REGISTER.REG_TYPE_ID IS 'Типу реєстру';
COMMENT ON COLUMN BARS.ESCR_REGISTER.REG_KIND_ID IS 'Вид реєстру';
COMMENT ON COLUMN BARS.ESCR_REGISTER.REG_LEVEL IS '1-ЦА,0-РУ';
COMMENT ON COLUMN BARS.ESCR_REGISTER.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARS.ESCR_REGISTER.USER_NAME IS 'Користувач,який створив реєстр ПІБ';
COMMENT ON COLUMN BARS.ESCR_REGISTER.FILE_ID IS 'ID файлу, з якого було сформовано реєстр (для ЦБД)';
COMMENT ON COLUMN BARS.ESCR_REGISTER.KF IS '';




PROMPT *** Create  constraint CC_ESCR_REGISTER_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REGISTER ADD CONSTRAINT CC_ESCR_REGISTER_ID CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_REG_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REGISTER ADD CONSTRAINT PK_REG_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REG_STATUS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REGISTER ADD CONSTRAINT FK_REG_STATUS_ID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.ESCR_REG_STATUS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REGISTER_INNER_NUMBER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REGISTER ADD CONSTRAINT CC_ESCR_REGISTER_INNER_NUMBER CHECK (INNER_NUMBER IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REG_KIND_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REGISTER ADD CONSTRAINT FK_REG_KIND_ID FOREIGN KEY (REG_KIND_ID)
	  REFERENCES BARS.ESCR_REG_KIND (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REG_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REG_ID ON BARS.ESCR_REGISTER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_REGISTER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_REGISTER   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_REGISTER.sql =========*** End ***
PROMPT ===================================================================================== 
