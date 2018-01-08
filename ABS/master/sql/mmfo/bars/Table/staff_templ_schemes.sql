

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_TEMPL_SCHEMES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_TEMPL_SCHEMES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_TEMPL_SCHEMES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TEMPL_SCHEMES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TEMPL_SCHEMES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_TEMPL_SCHEMES ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_TEMPL_SCHEMES 
   (	SCHEME_ID NUMBER(38,0), 
	SCHEME_USER VARCHAR2(30), 
	SCHEME_ROLE VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_TEMPL_SCHEMES ***
 exec bpa.alter_policies('STAFF_TEMPL_SCHEMES');


COMMENT ON TABLE BARS.STAFF_TEMPL_SCHEMES IS 'Схемы общих пользователей';
COMMENT ON COLUMN BARS.STAFF_TEMPL_SCHEMES.SCHEME_ID IS 'Ид. схемы';
COMMENT ON COLUMN BARS.STAFF_TEMPL_SCHEMES.SCHEME_USER IS 'Имя общего пользователя в базе данных';
COMMENT ON COLUMN BARS.STAFF_TEMPL_SCHEMES.SCHEME_ROLE IS 'Роль общего пользователя в базе данных';




PROMPT *** Create  constraint PK_TEMPLSCHEMES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPL_SCHEMES ADD CONSTRAINT PK_TEMPLSCHEMES PRIMARY KEY (SCHEME_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_TEMPLSCHEMES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPL_SCHEMES ADD CONSTRAINT UK_TEMPLSCHEMES UNIQUE (SCHEME_USER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK2_TEMPLSCHEMES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPL_SCHEMES ADD CONSTRAINT UK2_TEMPLSCHEMES UNIQUE (SCHEME_ROLE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TEMPLSCHEMES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPL_SCHEMES MODIFY (SCHEME_ID CONSTRAINT CC_TEMPLSCHEMES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TEMPLSCHEMES_USER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPL_SCHEMES MODIFY (SCHEME_USER CONSTRAINT CC_TEMPLSCHEMES_USER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TEMPLSCHEMES_ROLE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPL_SCHEMES MODIFY (SCHEME_ROLE CONSTRAINT CC_TEMPLSCHEMES_ROLE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TEMPLSCHEMES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TEMPLSCHEMES ON BARS.STAFF_TEMPL_SCHEMES (SCHEME_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_TEMPLSCHEMES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_TEMPLSCHEMES ON BARS.STAFF_TEMPL_SCHEMES (SCHEME_ROLE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_TEMPLSCHEMES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_TEMPLSCHEMES ON BARS.STAFF_TEMPL_SCHEMES (SCHEME_USER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_TEMPL_SCHEMES ***
grant SELECT                                                                 on STAFF_TEMPL_SCHEMES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_TEMPL_SCHEMES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_TEMPL_SCHEMES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_TEMPL_SCHEMES to START1;
grant SELECT                                                                 on STAFF_TEMPL_SCHEMES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_TEMPL_SCHEMES.sql =========*** E
PROMPT ===================================================================================== 
