

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/CLAIM.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  table CLAIM ***
begin 
  execute immediate '
  CREATE TABLE CDB.CLAIM 
   (	ID NUMBER(10,0), 
	CLAIM_TYPE_ID NUMBER(5,0), 
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


COMMENT ON TABLE CDB.CLAIM IS '';
COMMENT ON COLUMN CDB.CLAIM.ID IS '';
COMMENT ON COLUMN CDB.CLAIM.CLAIM_TYPE_ID IS '';
COMMENT ON COLUMN CDB.CLAIM.STATE IS '';
COMMENT ON COLUMN CDB.CLAIM.SYS_TIME IS '';




PROMPT *** Create  constraint PK_CLAIM ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM ADD CONSTRAINT PK_CLAIM PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118914 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118915 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM MODIFY (CLAIM_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118916 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118917 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLAIM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_CLAIM ON CDB.CLAIM (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLAIM ***
grant SELECT                                                                 on CLAIM           to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/CLAIM.sql =========*** End *** ========
PROMPT ===================================================================================== 
