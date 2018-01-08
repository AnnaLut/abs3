

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ROLES$BASE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ROLES$BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ROLES$BASE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ROLES$BASE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ROLES$BASE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ROLES$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ROLES$BASE 
   (	ROLE_NAME VARCHAR2(30), 
	ROLE_ID VARCHAR2(100), 
	AUTHENTICATED NUMBER(1,0) DEFAULT 1, 
	APPLICATION_ROLE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ROLES$BASE ***
 exec bpa.alter_policies('ROLES$BASE');


COMMENT ON TABLE BARS.ROLES$BASE IS 'Хранилище ролей';
COMMENT ON COLUMN BARS.ROLES$BASE.ROLE_NAME IS 'Имя роли';
COMMENT ON COLUMN BARS.ROLES$BASE.ROLE_ID IS 'Идентификация роли';
COMMENT ON COLUMN BARS.ROLES$BASE.AUTHENTICATED IS 'Признак аутетифицируемой роли';
COMMENT ON COLUMN BARS.ROLES$BASE.APPLICATION_ROLE IS 'Признак того, что роль идентифицируется пакетом';




PROMPT *** Create  constraint CC_ROLES_ROLENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ROLES$BASE MODIFY (ROLE_NAME CONSTRAINT CC_ROLES_ROLENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ROLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ROLES$BASE ADD CONSTRAINT PK_ROLES PRIMARY KEY (ROLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ROLES_AUTH ***
begin   
 execute immediate '
  ALTER TABLE BARS.ROLES$BASE ADD CONSTRAINT CC_ROLES_AUTH CHECK (authenticated in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ROLES_APPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ROLES$BASE ADD CONSTRAINT CC_ROLES_APPL CHECK (application_role in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ROLESBASE_ROLENAME_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ROLES$BASE ADD CONSTRAINT CC_ROLESBASE_ROLENAME_CC CHECK (role_name=upper(role_name)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ROLES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ROLES ON BARS.ROLES$BASE (ROLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ROLES$BASE ***
grant SELECT                                                                 on ROLES$BASE      to ABS_ADMIN;
grant SELECT                                                                 on ROLES$BASE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ROLES$BASE      to BARS_CONNECT;
grant SELECT                                                                 on ROLES$BASE      to BARS_DM;
grant SELECT                                                                 on ROLES$BASE      to PUBLIC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ROLES$BASE      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ROLES$BASE.sql =========*** End *** ==
PROMPT ===================================================================================== 
