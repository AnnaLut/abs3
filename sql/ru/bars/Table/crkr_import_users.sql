

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CRKR_IMPORT_USERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CRKR_IMPORT_USERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CRKR_IMPORT_USERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CRKR_IMPORT_USERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CRKR_IMPORT_USERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CRKR_IMPORT_USERS 
   (	LOGNAME VARCHAR2(400), 
	FIO VARCHAR2(400), 
	BRANCH VARCHAR2(30), 
	CANSELECTBRANCH CHAR(1), 
	DATEPRIVSTART DATE, 
	DATEPRIVEND DATE, 
	STATE VARCHAR2(100), 
	ERRORMESSAGE VARCHAR2(4000), 
	METHOD CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CRKR_IMPORT_USERS ***
 exec bpa.alter_policies('CRKR_IMPORT_USERS');


COMMENT ON TABLE BARS.CRKR_IMPORT_USERS IS '';
COMMENT ON COLUMN BARS.CRKR_IMPORT_USERS.LOGNAME IS '';
COMMENT ON COLUMN BARS.CRKR_IMPORT_USERS.FIO IS '';
COMMENT ON COLUMN BARS.CRKR_IMPORT_USERS.BRANCH IS '';
COMMENT ON COLUMN BARS.CRKR_IMPORT_USERS.CANSELECTBRANCH IS '';
COMMENT ON COLUMN BARS.CRKR_IMPORT_USERS.DATEPRIVSTART IS '';
COMMENT ON COLUMN BARS.CRKR_IMPORT_USERS.DATEPRIVEND IS '';
COMMENT ON COLUMN BARS.CRKR_IMPORT_USERS.STATE IS '';
COMMENT ON COLUMN BARS.CRKR_IMPORT_USERS.ERRORMESSAGE IS '';
COMMENT ON COLUMN BARS.CRKR_IMPORT_USERS.METHOD IS '';




PROMPT *** Create  constraint SYS_C003289915 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRKR_IMPORT_USERS ADD PRIMARY KEY (LOGNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C003289915 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C003289915 ON BARS.CRKR_IMPORT_USERS (LOGNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CRKR_IMPORT_USERS.sql =========*** End
PROMPT ===================================================================================== 
