

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_CHECK_OBJECTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_CHECK_OBJECTS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_CHECK_OBJECTS 
   (	OBJECT_ID NUMBER(1,0), 
	OBJECT_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_CHECK_OBJECTS IS '';
COMMENT ON COLUMN BARSUPL.UPL_CHECK_OBJECTS.OBJECT_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_CHECK_OBJECTS.OBJECT_NAME IS '';




PROMPT *** Create  constraint PK_CHECKOBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CHECK_OBJECTS ADD CONSTRAINT PK_CHECKOBJECTS PRIMARY KEY (OBJECT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHECKOBJECTS_OBJECTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CHECK_OBJECTS MODIFY (OBJECT_ID CONSTRAINT CC_CHECKOBJECTS_OBJECTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHECKOBJECTS_OBJECTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CHECK_OBJECTS MODIFY (OBJECT_NAME CONSTRAINT CC_CHECKOBJECTS_OBJECTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CHECKOBJECTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_CHECKOBJECTS ON BARSUPL.UPL_CHECK_OBJECTS (OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_CHECK_OBJECTS ***
grant SELECT                                                                 on UPL_CHECK_OBJECTS to BARS;
grant SELECT                                                                 on UPL_CHECK_OBJECTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_CHECK_OBJECTS.sql =========*** 
PROMPT ===================================================================================== 
