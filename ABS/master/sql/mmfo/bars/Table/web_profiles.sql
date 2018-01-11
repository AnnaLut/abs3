

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_PROFILES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_PROFILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_PROFILES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_PROFILES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''WEB_PROFILES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_PROFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_PROFILES 
   (	PROFILE_ID VARCHAR2(30), 
	PROFILE_NAME VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_PROFILES ***
 exec bpa.alter_policies('WEB_PROFILES');


COMMENT ON TABLE BARS.WEB_PROFILES IS 'Профили';
COMMENT ON COLUMN BARS.WEB_PROFILES.PROFILE_ID IS 'Идентификатор профиля';
COMMENT ON COLUMN BARS.WEB_PROFILES.PROFILE_NAME IS 'Наименование профиля';




PROMPT *** Create  constraint XPK_WEB_PROFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_PROFILES ADD CONSTRAINT XPK_WEB_PROFILES PRIMARY KEY (PROFILE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_WEB_PROFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_WEB_PROFILES ON BARS.WEB_PROFILES (PROFILE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_PROFILES ***
grant SELECT                                                                 on WEB_PROFILES    to ABS_ADMIN;
grant SELECT                                                                 on WEB_PROFILES    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_PROFILES    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WEB_PROFILES    to BARS_DM;
grant SELECT                                                                 on WEB_PROFILES    to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_PROFILES    to WEB_PROFILES;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_PROFILES    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on WEB_PROFILES    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_PROFILES.sql =========*** End *** 
PROMPT ===================================================================================== 
