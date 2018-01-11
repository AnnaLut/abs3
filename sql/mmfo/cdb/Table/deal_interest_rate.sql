

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/DEAL_INTEREST_RATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table DEAL_INTEREST_RATE ***
begin 
  execute immediate '
  CREATE TABLE CDB.DEAL_INTEREST_RATE 
   (	ID NUMBER(10,0), 
	DEAL_ID NUMBER(10,0), 
	RATE_KIND NUMBER(5,0), 
	START_DATE DATE, 
	INTEREST_RATE NUMBER(22,12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.DEAL_INTEREST_RATE IS '';
COMMENT ON COLUMN CDB.DEAL_INTEREST_RATE.ID IS '';
COMMENT ON COLUMN CDB.DEAL_INTEREST_RATE.DEAL_ID IS '';
COMMENT ON COLUMN CDB.DEAL_INTEREST_RATE.RATE_KIND IS '';
COMMENT ON COLUMN CDB.DEAL_INTEREST_RATE.START_DATE IS '';
COMMENT ON COLUMN CDB.DEAL_INTEREST_RATE.INTEREST_RATE IS '';




PROMPT *** Create  constraint SYS_C00118934 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL_INTEREST_RATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118935 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL_INTEREST_RATE MODIFY (DEAL_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118936 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL_INTEREST_RATE MODIFY (RATE_KIND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118937 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL_INTEREST_RATE MODIFY (START_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DEAL_INTEREST_RATE ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL_INTEREST_RATE ADD CONSTRAINT PK_DEAL_INTEREST_RATE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint AK_KEY_1_DEAL_INT ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL_INTEREST_RATE ADD CONSTRAINT AK_KEY_1_DEAL_INT UNIQUE (DEAL_ID, RATE_KIND, START_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEAL_INTEREST_RATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_DEAL_INTEREST_RATE ON CDB.DEAL_INTEREST_RATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index AK_KEY_1_DEAL_INT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.AK_KEY_1_DEAL_INT ON CDB.DEAL_INTEREST_RATE (DEAL_ID, RATE_KIND, START_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEAL_INTEREST_RATE ***
grant SELECT                                                                 on DEAL_INTEREST_RATE to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/DEAL_INTEREST_RATE.sql =========*** End
PROMPT ===================================================================================== 
