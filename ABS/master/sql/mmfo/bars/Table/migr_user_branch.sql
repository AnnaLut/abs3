

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIGR_USER_BRANCH.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIGR_USER_BRANCH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIGR_USER_BRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIGR_USER_BRANCH 
   (	ID NUMBER(38,0), 
	FIO VARCHAR2(60), 
	LOGNAME VARCHAR2(30), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIGR_USER_BRANCH ***
 exec bpa.alter_policies('MIGR_USER_BRANCH');


COMMENT ON TABLE BARS.MIGR_USER_BRANCH IS '';
COMMENT ON COLUMN BARS.MIGR_USER_BRANCH.ID IS '';
COMMENT ON COLUMN BARS.MIGR_USER_BRANCH.FIO IS '';
COMMENT ON COLUMN BARS.MIGR_USER_BRANCH.LOGNAME IS '';
COMMENT ON COLUMN BARS.MIGR_USER_BRANCH.BRANCH IS '';




PROMPT *** Create  constraint PK_MIGRUB ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_USER_BRANCH ADD CONSTRAINT PK_MIGRUB PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRUB_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_USER_BRANCH MODIFY (ID CONSTRAINT CC_MIGRUB_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRUB_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_USER_BRANCH MODIFY (BRANCH CONSTRAINT CC_MIGRUB_BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MIGRUB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MIGRUB ON BARS.MIGR_USER_BRANCH (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MIGR_USER_BRANCH ***
grant SELECT                                                                 on MIGR_USER_BRANCH to BARSREADER_ROLE;
grant SELECT                                                                 on MIGR_USER_BRANCH to BARS_DM;
grant SELECT                                                                 on MIGR_USER_BRANCH to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MIGR_USER_BRANCH to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIGR_USER_BRANCH.sql =========*** End 
PROMPT ===================================================================================== 
