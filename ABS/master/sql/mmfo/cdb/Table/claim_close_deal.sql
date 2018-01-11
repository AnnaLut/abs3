

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/CLAIM_CLOSE_DEAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table CLAIM_CLOSE_DEAL ***
begin 
  execute immediate '
  CREATE TABLE CDB.CLAIM_CLOSE_DEAL 
   (	CLAIM_ID NUMBER(10,0), 
	DEAL_NUMBER VARCHAR2(30 CHAR), 
	CLOSE_DATE DATE, 
	CURRENCY_ID NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.CLAIM_CLOSE_DEAL IS '';
COMMENT ON COLUMN CDB.CLAIM_CLOSE_DEAL.CLAIM_ID IS '';
COMMENT ON COLUMN CDB.CLAIM_CLOSE_DEAL.DEAL_NUMBER IS '';
COMMENT ON COLUMN CDB.CLAIM_CLOSE_DEAL.CLOSE_DATE IS '';
COMMENT ON COLUMN CDB.CLAIM_CLOSE_DEAL.CURRENCY_ID IS '';




PROMPT *** Create  constraint PK_CLAIM_CLOSE_DEAL ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_CLOSE_DEAL ADD CONSTRAINT PK_CLAIM_CLOSE_DEAL PRIMARY KEY (CLAIM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118918 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_CLOSE_DEAL MODIFY (CLAIM_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLAIM_CLOSE_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_CLAIM_CLOSE_DEAL ON CDB.CLAIM_CLOSE_DEAL (CLAIM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLAIM_CLOSE_DEAL ***
grant SELECT                                                                 on CLAIM_CLOSE_DEAL to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/CLAIM_CLOSE_DEAL.sql =========*** End *
PROMPT ===================================================================================== 
