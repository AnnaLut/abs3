

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/CLAIM_EXTERNAL_ID.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table CLAIM_EXTERNAL_ID ***
begin 
  execute immediate '
  CREATE TABLE CDB.CLAIM_EXTERNAL_ID 
   (	CLAIM_ID NUMBER(10,0), 
	EXTERNAL_ID VARCHAR2(30 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.CLAIM_EXTERNAL_ID IS '';
COMMENT ON COLUMN CDB.CLAIM_EXTERNAL_ID.CLAIM_ID IS '';
COMMENT ON COLUMN CDB.CLAIM_EXTERNAL_ID.EXTERNAL_ID IS '';




PROMPT *** Create  constraint SYS_C00118928 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_EXTERNAL_ID MODIFY (CLAIM_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118929 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_EXTERNAL_ID MODIFY (EXTERNAL_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CLAIM_EXTERNAL_ID ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_EXTERNAL_ID ADD CONSTRAINT PK_CLAIM_EXTERNAL_ID PRIMARY KEY (CLAIM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLAIM_EXTERNAL_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_CLAIM_EXTERNAL_ID ON CDB.CLAIM_EXTERNAL_ID (CLAIM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CLAIM_EXTERNAL_ID_IDX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.CLAIM_EXTERNAL_ID_IDX ON CDB.CLAIM_EXTERNAL_ID (EXTERNAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLAIM_EXTERNAL_ID ***
grant SELECT                                                                 on CLAIM_EXTERNAL_ID to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/CLAIM_EXTERNAL_ID.sql =========*** End 
PROMPT ===================================================================================== 
