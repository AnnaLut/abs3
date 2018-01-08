

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/BARS_OBJECT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table BARS_OBJECT ***
begin 
  execute immediate '
  CREATE TABLE CDB.BARS_OBJECT 
   (	ID NUMBER(38,0), 
	OBJECT_TYPE NUMBER(5,0), 
	DEAL_ID NUMBER(38,0), 
	BRANCH_ID NUMBER(5,0), 
	BARS_OBJECT_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.BARS_OBJECT IS '';
COMMENT ON COLUMN CDB.BARS_OBJECT.ID IS '';
COMMENT ON COLUMN CDB.BARS_OBJECT.OBJECT_TYPE IS '';
COMMENT ON COLUMN CDB.BARS_OBJECT.DEAL_ID IS '';
COMMENT ON COLUMN CDB.BARS_OBJECT.BRANCH_ID IS '';
COMMENT ON COLUMN CDB.BARS_OBJECT.BARS_OBJECT_ID IS '';




PROMPT *** Create  constraint PK_BARS_OBJECT ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_OBJECT ADD CONSTRAINT PK_BARS_OBJECT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118869 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_OBJECT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118870 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_OBJECT MODIFY (OBJECT_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118871 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BARS_OBJECT MODIFY (BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARS_OBJECT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_BARS_OBJECT ON CDB.BARS_OBJECT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BARS_OBJECT_IDX ***
begin   
 execute immediate '
  CREATE INDEX CDB.BARS_OBJECT_IDX ON CDB.BARS_OBJECT (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BARS_OBJECT_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX CDB.BARS_OBJECT_IDX2 ON CDB.BARS_OBJECT (BARS_OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_OBJECT ***
grant SELECT                                                                 on BARS_OBJECT     to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/BARS_OBJECT.sql =========*** End *** ==
PROMPT ===================================================================================== 
