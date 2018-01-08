

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_USER_MAPPING_SNAPSHOT.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_USER_MAPPING_SNAPSHOT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_USER_MAPPING_SNAPSHOT ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_USER_MAPPING_SNAPSHOT 
   (	BRANCH VARCHAR2(30), 
	CURRENT_LOGNAME VARCHAR2(30), 
	REDUNDANT_LOGNAME VARCHAR2(30), 
	OLD_LOGNAME VARCHAR2(30 CHAR), 
	CURRENT_ID NUMBER(38,0), 
	REDUNDANT_ID NUMBER(38,0), 
	OLD_ID NUMBER(38,0), 
	OLD_BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_USER_MAPPING_SNAPSHOT ***
 exec bpa.alter_policies('STAFF_USER_MAPPING_SNAPSHOT');


COMMENT ON TABLE BARS.STAFF_USER_MAPPING_SNAPSHOT IS '';
COMMENT ON COLUMN BARS.STAFF_USER_MAPPING_SNAPSHOT.BRANCH IS '';
COMMENT ON COLUMN BARS.STAFF_USER_MAPPING_SNAPSHOT.CURRENT_LOGNAME IS '';
COMMENT ON COLUMN BARS.STAFF_USER_MAPPING_SNAPSHOT.REDUNDANT_LOGNAME IS '';
COMMENT ON COLUMN BARS.STAFF_USER_MAPPING_SNAPSHOT.OLD_LOGNAME IS '';
COMMENT ON COLUMN BARS.STAFF_USER_MAPPING_SNAPSHOT.CURRENT_ID IS '';
COMMENT ON COLUMN BARS.STAFF_USER_MAPPING_SNAPSHOT.REDUNDANT_ID IS '';
COMMENT ON COLUMN BARS.STAFF_USER_MAPPING_SNAPSHOT.OLD_ID IS '';
COMMENT ON COLUMN BARS.STAFF_USER_MAPPING_SNAPSHOT.OLD_BRANCH IS '';




PROMPT *** Create  constraint SYS_C00132334 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_USER_MAPPING_SNAPSHOT MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132335 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_USER_MAPPING_SNAPSHOT MODIFY (CURRENT_LOGNAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132336 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_USER_MAPPING_SNAPSHOT MODIFY (CURRENT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_USER_MAPPING_SNAP_CURR_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_USER_MAPPING_SNAP_CURR_ID ON BARS.STAFF_USER_MAPPING_SNAPSHOT (CURRENT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_USER_MAPPING_SNAP_RED_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_USER_MAPPING_SNAP_RED_ID ON BARS.STAFF_USER_MAPPING_SNAPSHOT (REDUNDANT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_USER_MAPPING_SNAPSHOT ***
grant SELECT                                                                 on STAFF_USER_MAPPING_SNAPSHOT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_USER_MAPPING_SNAPSHOT.sql ======
PROMPT ===================================================================================== 
