

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/ATTRIBUTE_HISTORY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table ATTRIBUTE_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE CDB.ATTRIBUTE_HISTORY 
   (	ID NUMBER(10,0), 
	DEAL_ID NUMBER(10,0), 
	ATTRIBUTE_ID NUMBER(5,0), 
	SYS_TIME DATE, 
	IS_DELETE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.ATTRIBUTE_HISTORY IS '';
COMMENT ON COLUMN CDB.ATTRIBUTE_HISTORY.ID IS '';
COMMENT ON COLUMN CDB.ATTRIBUTE_HISTORY.DEAL_ID IS '';
COMMENT ON COLUMN CDB.ATTRIBUTE_HISTORY.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN CDB.ATTRIBUTE_HISTORY.SYS_TIME IS '';
COMMENT ON COLUMN CDB.ATTRIBUTE_HISTORY.IS_DELETE IS '';




PROMPT *** Create  constraint PK_ATTRIBUTE_HISTORY ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_HISTORY ADD CONSTRAINT PK_ATTRIBUTE_HISTORY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118864 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_HISTORY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118865 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_HISTORY MODIFY (DEAL_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118866 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_HISTORY MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118867 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_HISTORY MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118868 ***
begin   
 execute immediate '
  ALTER TABLE CDB.ATTRIBUTE_HISTORY MODIFY (IS_DELETE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_HISTORY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_ATTRIBUTE_HISTORY ON CDB.ATTRIBUTE_HISTORY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index ATTRIBUTE_HISTORY_IDX ***
begin   
 execute immediate '
  CREATE INDEX CDB.ATTRIBUTE_HISTORY_IDX ON CDB.ATTRIBUTE_HISTORY (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_HISTORY ***
grant SELECT                                                                 on ATTRIBUTE_HISTORY to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/ATTRIBUTE_HISTORY.sql =========*** End 
PROMPT ===================================================================================== 
