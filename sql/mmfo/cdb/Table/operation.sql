

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/OPERATION.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  table OPERATION ***
begin 
  execute immediate '
  CREATE TABLE CDB.OPERATION 
   (	ID NUMBER(10,0), 
	DEAL_ID NUMBER(10,0), 
	OPERATION_TYPE NUMBER(5,0), 
	CLAIM_ID NUMBER(10,0), 
	STATE NUMBER(5,0), 
	SYS_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.OPERATION IS '';
COMMENT ON COLUMN CDB.OPERATION.ID IS '';
COMMENT ON COLUMN CDB.OPERATION.DEAL_ID IS '';
COMMENT ON COLUMN CDB.OPERATION.OPERATION_TYPE IS '';
COMMENT ON COLUMN CDB.OPERATION.CLAIM_ID IS '';
COMMENT ON COLUMN CDB.OPERATION.STATE IS '';
COMMENT ON COLUMN CDB.OPERATION.SYS_TIME IS '';




PROMPT *** Create  constraint PK_OPERATION ***
begin   
 execute immediate '
  ALTER TABLE CDB.OPERATION ADD CONSTRAINT PK_OPERATION PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118881 ***
begin   
 execute immediate '
  ALTER TABLE CDB.OPERATION MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118882 ***
begin   
 execute immediate '
  ALTER TABLE CDB.OPERATION MODIFY (DEAL_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118883 ***
begin   
 execute immediate '
  ALTER TABLE CDB.OPERATION MODIFY (OPERATION_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118884 ***
begin   
 execute immediate '
  ALTER TABLE CDB.OPERATION MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118885 ***
begin   
 execute immediate '
  ALTER TABLE CDB.OPERATION MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPERATION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_OPERATION ON CDB.OPERATION (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OPERATION_IDX ***
begin   
 execute immediate '
  CREATE INDEX CDB.OPERATION_IDX ON CDB.OPERATION (CLAIM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OPERATION_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX CDB.OPERATION_IDX2 ON CDB.OPERATION (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPERATION ***
grant SELECT                                                                 on OPERATION       to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/OPERATION.sql =========*** End *** ====
PROMPT ===================================================================================== 
