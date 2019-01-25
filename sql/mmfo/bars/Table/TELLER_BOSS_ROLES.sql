PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_BOSS_ROLES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_BOSS_ROLES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_BOSS_ROLES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_BOSS_ROLES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_BOSS_ROLES 
   (	USERROLE VARCHAR2(10), 
	PRIORITY NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_BOSS_ROLES ***
 exec bpa.alter_policies('TELLER_BOSS_ROLES');


COMMENT ON TABLE BARS.TELLER_BOSS_ROLES IS '';
COMMENT ON COLUMN BARS.TELLER_BOSS_ROLES.USERROLE IS '';
COMMENT ON COLUMN BARS.TELLER_BOSS_ROLES.PRIORITY IS '';




PROMPT *** Create  constraint TELLER_BOSS_ROLES_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_BOSS_ROLES ADD CONSTRAINT TELLER_BOSS_ROLES_PK PRIMARY KEY (USERROLE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index TELLER_BOSS_ROLES_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.TELLER_BOSS_ROLES_PK ON BARS.TELLER_BOSS_ROLES (USERROLE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TELLER_BOSS_ROLES ***
grant FLASHBACK,SELECT                                                       on TELLER_BOSS_ROLES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_BOSS_ROLES.sql =========*** End
PROMPT ===================================================================================== 
