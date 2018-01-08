

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_MAPPING.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_REG_MAPPING ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_REG_MAPPING 
   (	ID NUMBER, 
	IN_DOC_ID NUMBER, 
	IN_DOC_TYPE NUMBER, 
	OPER_DATE DATE, 
	OUT_DOC_ID NUMBER, 
	OUT_DOC_TYPE NUMBER, 
	BRANCH VARCHAR2(30), 
	OPER_TYPE NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_REG_MAPPING IS 'Таблиця взаємозв'язків між об'єктами реєстру';
COMMENT ON COLUMN BARSAQ.ESCR_REG_MAPPING.ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_MAPPING.IN_DOC_ID IS 'ID вхідного об'єкта';
COMMENT ON COLUMN BARSAQ.ESCR_REG_MAPPING.IN_DOC_TYPE IS 'Тип вхідного  об'єкта (1 -реєстр,0-кредит)';
COMMENT ON COLUMN BARSAQ.ESCR_REG_MAPPING.OPER_DATE IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_MAPPING.OUT_DOC_ID IS 'ID вихідного об'єкта';
COMMENT ON COLUMN BARSAQ.ESCR_REG_MAPPING.OUT_DOC_TYPE IS 'Тип вихідного  об'єкта (1 -реєстр,0-кредит)';
COMMENT ON COLUMN BARSAQ.ESCR_REG_MAPPING.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARSAQ.ESCR_REG_MAPPING.OPER_TYPE IS '0-реєстр-кредит,1- реєстр-реєстр';




PROMPT *** Create  constraint UK_REG_MAP ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_MAPPING ADD CONSTRAINT UK_REG_MAP UNIQUE (IN_DOC_ID, OUT_DOC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_REG_MAP_OUT_DOC_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_MAPPING ADD CONSTRAINT UK_REG_MAP_OUT_DOC_ID UNIQUE (OUT_DOC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_REG_MAP_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_MAPPING ADD CONSTRAINT PK_REG_MAP_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_MAPPING_OPER_DATE ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_MAPPING ADD CONSTRAINT CC_ESCR_REG_MAPPING_OPER_DATE CHECK (OPER_DATE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_MAPPING_OPER_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_MAPPING ADD CONSTRAINT CC_ESCR_REG_MAPPING_OPER_TYPE CHECK (OPER_TYPE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_MAPPING_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_MAPPING ADD CONSTRAINT CC_ESCR_REG_MAPPING_BRANCH CHECK (BRANCH IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_MAPPING_OUT_DOC11 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_MAPPING ADD CONSTRAINT CC_ESCR_REG_MAPPING_OUT_DOC11 CHECK (OUT_DOC_TYPE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_MAPPING_IN_DOC_8 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_MAPPING ADD CONSTRAINT CC_ESCR_REG_MAPPING_IN_DOC_8 CHECK (IN_DOC_TYPE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_MAPPING_IN_DOC_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_MAPPING ADD CONSTRAINT CC_ESCR_REG_MAPPING_IN_DOC_ID CHECK (IN_DOC_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_MAPPING_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_MAPPING ADD CONSTRAINT CC_ESCR_REG_MAPPING_ID CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_MAPPING_OUT_DOC_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_MAPPING ADD CONSTRAINT CC_ESCR_REG_MAPPING_OUT_DOC_ID CHECK (OUT_DOC_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_REG_MAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.UK_REG_MAP ON BARSAQ.ESCR_REG_MAPPING (IN_DOC_ID, OUT_DOC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_REG_MAP_OUT_DOC_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.UK_REG_MAP_OUT_DOC_ID ON BARSAQ.ESCR_REG_MAPPING (OUT_DOC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REG_MAP_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_REG_MAP_ID ON BARSAQ.ESCR_REG_MAPPING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_REG_MAPPING ***
grant SELECT                                                                 on ESCR_REG_MAPPING to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_MAPPING.sql =========*** En
PROMPT ===================================================================================== 
