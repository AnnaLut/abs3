

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_USER_SESSION.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_USER_SESSION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_USER_SESSION'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_USER_SESSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_USER_SESSION 
   (	ID NUMBER(38,0), 
	CLIENT_IDENTIFIER VARCHAR2(64 CHAR), 
	USER_ID NUMBER(38,0), 
	CLIENT_HOST VARCHAR2(255 CHAR), 
	PROGRAM_NAME VARCHAR2(255 CHAR), 
	LOGIN_TIME DATE, 
	LOGOUT_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_USER_SESSION ***
 exec bpa.alter_policies('STAFF_USER_SESSION');


COMMENT ON TABLE BARS.STAFF_USER_SESSION IS '';
COMMENT ON COLUMN BARS.STAFF_USER_SESSION.ID IS '';
COMMENT ON COLUMN BARS.STAFF_USER_SESSION.CLIENT_IDENTIFIER IS '';
COMMENT ON COLUMN BARS.STAFF_USER_SESSION.USER_ID IS '';
COMMENT ON COLUMN BARS.STAFF_USER_SESSION.CLIENT_HOST IS '';
COMMENT ON COLUMN BARS.STAFF_USER_SESSION.PROGRAM_NAME IS '';
COMMENT ON COLUMN BARS.STAFF_USER_SESSION.LOGIN_TIME IS '';
COMMENT ON COLUMN BARS.STAFF_USER_SESSION.LOGOUT_TIME IS '';




PROMPT *** Create  constraint SYS_C0025716 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_USER_SESSION MODIFY (CLIENT_IDENTIFIER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025717 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_USER_SESSION MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025718 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_USER_SESSION MODIFY (LOGIN_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_STAFF_SESSION_CLIENT_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_STAFF_SESSION_CLIENT_ID ON BARS.STAFF_USER_SESSION (CLIENT_IDENTIFIER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_USER_SESSION ***
grant SELECT                                                                 on STAFF_USER_SESSION to BARSREADER_ROLE;
grant SELECT                                                                 on STAFF_USER_SESSION to BARS_DM;
grant SELECT                                                                 on STAFF_USER_SESSION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_USER_SESSION.sql =========*** En
PROMPT ===================================================================================== 
