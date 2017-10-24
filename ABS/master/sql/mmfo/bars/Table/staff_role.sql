

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_ROLE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_ROLE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_ROLE'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_ROLE ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_ROLE 
   (	ID NUMBER(38,0), 
	ROLE_CODE VARCHAR2(255 CHAR), 
	ROLE_NAME VARCHAR2(300 CHAR), 
	STATE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_ROLE ***
 exec bpa.alter_policies('STAFF_ROLE');


COMMENT ON TABLE BARS.STAFF_ROLE IS '';
COMMENT ON COLUMN BARS.STAFF_ROLE.ID IS '';
COMMENT ON COLUMN BARS.STAFF_ROLE.ROLE_CODE IS '';
COMMENT ON COLUMN BARS.STAFF_ROLE.ROLE_NAME IS '';
COMMENT ON COLUMN BARS.STAFF_ROLE.STATE_ID IS '';




PROMPT *** Create  constraint SYS_C0025720 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ROLE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025721 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ROLE MODIFY (ROLE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_STAFF_ROLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ROLE ADD CONSTRAINT UK_STAFF_ROLE UNIQUE (ROLE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025723 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ROLE ADD CHECK (STATE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STAFF_ROLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ROLE ADD CONSTRAINT PK_STAFF_ROLE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025722 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_ROLE ADD CHECK (ROLE_NAME IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFF_ROLE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFF_ROLE ON BARS.STAFF_ROLE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_STAFF_ROLE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_STAFF_ROLE ON BARS.STAFF_ROLE (ROLE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_ROLE ***
grant SELECT                                                                 on STAFF_ROLE      to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_ROLE.sql =========*** End *** ==
PROMPT ===================================================================================== 
