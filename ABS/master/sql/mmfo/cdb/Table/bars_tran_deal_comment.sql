

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/BARS_TRAN_DEAL_COMMENT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  table BARS_TRAN_DEAL_COMMENT ***
begin 
  execute immediate '
  CREATE TABLE CDB.BARS_TRAN_DEAL_COMMENT 
   (	TRANSACTION_ID NUMBER(10,0), 
	DEAL_COMMENT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.BARS_TRAN_DEAL_COMMENT IS '';
COMMENT ON COLUMN CDB.BARS_TRAN_DEAL_COMMENT.TRANSACTION_ID IS '';
COMMENT ON COLUMN CDB.BARS_TRAN_DEAL_COMMENT.DEAL_COMMENT IS '';




PROMPT *** Create  constraint PK_BARS_TRAN_DEAL_COMMENT ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRAN_DEAL_COMMENT ADD CONSTRAINT PK_BARS_TRAN_DEAL_COMMENT PRIMARY KEY (TRANSACTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118912 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRAN_DEAL_COMMENT MODIFY (TRANSACTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118913 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_TRAN_DEAL_COMMENT MODIFY (DEAL_COMMENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARS_TRAN_DEAL_COMMENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_BARS_TRAN_DEAL_COMMENT ON CDB.BARS_TRAN_DEAL_COMMENT (TRANSACTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_TRAN_DEAL_COMMENT ***
grant SELECT                                                                 on BARS_TRAN_DEAL_COMMENT to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/BARS_TRAN_DEAL_COMMENT.sql =========***
PROMPT ===================================================================================== 
