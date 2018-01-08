

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/BARS_DEAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  table BARS_DEAL ***
begin 
  execute immediate '
  CREATE TABLE CDB.BARS_DEAL 
   (	ID NUMBER(10,0), 
	DEAL_TYPE NUMBER(5,0), 
	PRODUCT NUMBER(5,0), 
	MAIN_ACCOUNT_ID NUMBER(10,0), 
	INTEREST_ACCOUNT_ID NUMBER(10,0), 
	TRANSIT_ACCOUNT_ID NUMBER(10,0), 
	PARTY_BARS_DEAL_ID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.BARS_DEAL IS '';
COMMENT ON COLUMN CDB.BARS_DEAL.ID IS '';
COMMENT ON COLUMN CDB.BARS_DEAL.DEAL_TYPE IS '';
COMMENT ON COLUMN CDB.BARS_DEAL.PRODUCT IS '';
COMMENT ON COLUMN CDB.BARS_DEAL.MAIN_ACCOUNT_ID IS '';
COMMENT ON COLUMN CDB.BARS_DEAL.INTEREST_ACCOUNT_ID IS '';
COMMENT ON COLUMN CDB.BARS_DEAL.TRANSIT_ACCOUNT_ID IS '';
COMMENT ON COLUMN CDB.BARS_DEAL.PARTY_BARS_DEAL_ID IS '';




PROMPT *** Create  constraint PK_BARS_DEAL ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_DEAL ADD CONSTRAINT PK_BARS_DEAL PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118909 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_DEAL MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118910 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_DEAL MODIFY (DEAL_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118911 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_DEAL MODIFY (PRODUCT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARS_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_BARS_DEAL ON CDB.BARS_DEAL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_DEAL ***
grant SELECT                                                                 on BARS_DEAL       to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/BARS_DEAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
