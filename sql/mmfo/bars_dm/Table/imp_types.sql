

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/IMP_TYPES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table IMP_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.IMP_TYPES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(300), 
	PROC VARCHAR2(300), 
	RUN_TIME_HOUR NUMBER, 
	RUN_TIME_MINUTE NUMBER, 
	TYPE_SHED CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.IMP_TYPES IS '';
COMMENT ON COLUMN BARS_DM.IMP_TYPES.ID IS '';
COMMENT ON COLUMN BARS_DM.IMP_TYPES.NAME IS '';
COMMENT ON COLUMN BARS_DM.IMP_TYPES.PROC IS '';
COMMENT ON COLUMN BARS_DM.IMP_TYPES.RUN_TIME_HOUR IS '';
COMMENT ON COLUMN BARS_DM.IMP_TYPES.RUN_TIME_MINUTE IS '';
COMMENT ON COLUMN BARS_DM.IMP_TYPES.TYPE_SHED IS '';




PROMPT *** Create  constraint PK_IMPTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.IMP_TYPES ADD CONSTRAINT PK_IMPTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IMPTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.IMP_TYPES MODIFY (NAME CONSTRAINT CC_IMPTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_IMPTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.PK_IMPTYPES ON BARS_DM.IMP_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IMP_TYPES ***
grant SELECT                                                                 on IMP_TYPES       to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/IMP_TYPES.sql =========*** End *** 
PROMPT ===================================================================================== 
