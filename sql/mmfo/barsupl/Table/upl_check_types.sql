

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_CHECK_TYPES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_CHECK_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_CHECK_TYPES 
   (	CHECK_ID NUMBER(5,0), 
	CHECK_NAME VARCHAR2(100), 
	CHECK_DESC VARCHAR2(500), 
	OBJECT_ID NUMBER(1,0), 
	FILE_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_CHECK_TYPES IS '';
COMMENT ON COLUMN BARSUPL.UPL_CHECK_TYPES.CHECK_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_CHECK_TYPES.CHECK_NAME IS '';
COMMENT ON COLUMN BARSUPL.UPL_CHECK_TYPES.CHECK_DESC IS '';
COMMENT ON COLUMN BARSUPL.UPL_CHECK_TYPES.OBJECT_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_CHECK_TYPES.FILE_ID IS '';




PROMPT *** Create  constraint PK_CHECKTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CHECK_TYPES ADD CONSTRAINT PK_CHECKTYPES PRIMARY KEY (CHECK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHECKTYPES_CHECKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CHECK_TYPES MODIFY (CHECK_ID CONSTRAINT CC_CHECKTYPES_CHECKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHECKTYPES_CHECKNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CHECK_TYPES MODIFY (CHECK_NAME CONSTRAINT CC_CHECKTYPES_CHECKNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHECKTYPES_CHECKDESC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CHECK_TYPES MODIFY (CHECK_DESC CONSTRAINT CC_CHECKTYPES_CHECKDESC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHECKTYPES_OBJECTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CHECK_TYPES MODIFY (OBJECT_ID CONSTRAINT CC_CHECKTYPES_OBJECTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CHECKTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_CHECKTYPES ON BARSUPL.UPL_CHECK_TYPES (CHECK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_CHECK_TYPES ***
grant SELECT                                                                 on UPL_CHECK_TYPES to BARS;
grant SELECT                                                                 on UPL_CHECK_TYPES to BARSREADER_ROLE;
grant SELECT                                                                 on UPL_CHECK_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_CHECK_TYPES.sql =========*** En
PROMPT ===================================================================================== 
