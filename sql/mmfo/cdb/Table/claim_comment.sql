

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/CLAIM_COMMENT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table CLAIM_COMMENT ***
begin 
  execute immediate '
  CREATE TABLE CDB.CLAIM_COMMENT 
   (	CLAIM_ID NUMBER(10,0), 
	COMMENT_TEXT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.CLAIM_COMMENT IS '';
COMMENT ON COLUMN CDB.CLAIM_COMMENT.CLAIM_ID IS '';
COMMENT ON COLUMN CDB.CLAIM_COMMENT.COMMENT_TEXT IS '';




PROMPT *** Create  constraint SYS_C00118926 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_COMMENT MODIFY (CLAIM_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118927 ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_COMMENT MODIFY (COMMENT_TEXT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CLAIM_COMMENT ***
begin   
 execute immediate '
  ALTER TABLE CDB.CLAIM_COMMENT ADD CONSTRAINT PK_CLAIM_COMMENT PRIMARY KEY (CLAIM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLAIM_COMMENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_CLAIM_COMMENT ON CDB.CLAIM_COMMENT (CLAIM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLAIM_COMMENT ***
grant SELECT                                                                 on CLAIM_COMMENT   to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/CLAIM_COMMENT.sql =========*** End *** 
PROMPT ===================================================================================== 
