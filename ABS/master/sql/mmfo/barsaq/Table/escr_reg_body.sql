

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_BODY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table ESCR_REG_BODY ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ESCR_REG_BODY 
   (	ID NUMBER, 
	DEAL_ID NUMBER, 
	DEAL_ADR_ID NUMBER, 
	DEAL_REGION VARCHAR2(4000), 
	DEAL_FULL_ADDRESS VARCHAR2(4000), 
	DEAL_BUILD_ID NUMBER, 
	DEAL_EVENT_ID NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ESCR_REG_BODY IS 'Портфель енергозберігаючих кредитів (специфікація)';
COMMENT ON COLUMN BARSAQ.ESCR_REG_BODY.ID IS '';
COMMENT ON COLUMN BARSAQ.ESCR_REG_BODY.DEAL_ID IS 'Ідентифікатор кредитного договору';
COMMENT ON COLUMN BARSAQ.ESCR_REG_BODY.DEAL_ADR_ID IS 'Ідентифікатор адреси';
COMMENT ON COLUMN BARSAQ.ESCR_REG_BODY.DEAL_REGION IS 'Дані кредиту: область';
COMMENT ON COLUMN BARSAQ.ESCR_REG_BODY.DEAL_FULL_ADDRESS IS 'Дані кредиту: повна адреса';
COMMENT ON COLUMN BARSAQ.ESCR_REG_BODY.DEAL_BUILD_ID IS 'Дані кредиту: тип будинку';
COMMENT ON COLUMN BARSAQ.ESCR_REG_BODY.DEAL_EVENT_ID IS 'Ідентифікатор енергоефективного заходу';




PROMPT *** Create  constraint CC_DEAL_EVENT_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_BODY ADD CONSTRAINT CC_DEAL_EVENT_ID CHECK (DEAL_EVENT_ID is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEAL_BUILD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_BODY ADD CONSTRAINT CC_DEAL_BUILD_ID CHECK (DEAL_BUILD_ID is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEAL_ADR_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_BODY ADD CONSTRAINT CC_DEAL_ADR_ID CHECK (DEAL_ADR_ID is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_REG_SPEC_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_BODY ADD CONSTRAINT PK_REG_SPEC_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_BODY_ID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ESCR_REG_BODY ADD CONSTRAINT CC_ESCR_REG_BODY_ID CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REG_SPEC_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_REG_SPEC_ID ON BARSAQ.ESCR_REG_BODY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_REG_BODY ***
grant SELECT                                                                 on ESCR_REG_BODY   to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ESCR_REG_BODY.sql =========*** End *
PROMPT ===================================================================================== 
