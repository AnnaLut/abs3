

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/DEAL_INTEREST_RATE_HISTORY.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  table DEAL_INTEREST_RATE_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE CDB.DEAL_INTEREST_RATE_HISTORY 
   (	INTEREST_RATE_ID NUMBER(10,0), 
	OPERATION_ID NUMBER(10,0), 
	INTEREST_RATE NUMBER(22,12), 
	SYS_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.DEAL_INTEREST_RATE_HISTORY IS '';
COMMENT ON COLUMN CDB.DEAL_INTEREST_RATE_HISTORY.INTEREST_RATE_ID IS '';
COMMENT ON COLUMN CDB.DEAL_INTEREST_RATE_HISTORY.OPERATION_ID IS '';
COMMENT ON COLUMN CDB.DEAL_INTEREST_RATE_HISTORY.INTEREST_RATE IS '';
COMMENT ON COLUMN CDB.DEAL_INTEREST_RATE_HISTORY.SYS_TIME IS '';




PROMPT *** Create  constraint SYS_C00118919 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL_INTEREST_RATE_HISTORY MODIFY (INTEREST_RATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118920 ***
begin   
 execute immediate '
  ALTER TABLE CDB.DEAL_INTEREST_RATE_HISTORY MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index INT_RATE_HIST_IDX1 ***
begin   
 execute immediate '
  CREATE INDEX CDB.INT_RATE_HIST_IDX1 ON CDB.DEAL_INTEREST_RATE_HISTORY (INTEREST_RATE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index INT_RATE_HIST_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX CDB.INT_RATE_HIST_IDX2 ON CDB.DEAL_INTEREST_RATE_HISTORY (OPERATION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEAL_INTEREST_RATE_HISTORY ***
grant SELECT                                                                 on DEAL_INTEREST_RATE_HISTORY to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/DEAL_INTEREST_RATE_HISTORY.sql ========
PROMPT ===================================================================================== 
