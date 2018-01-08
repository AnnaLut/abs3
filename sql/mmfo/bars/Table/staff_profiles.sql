

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_PROFILES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_PROFILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_PROFILES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_PROFILES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAFF_PROFILES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_PROFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_PROFILES 
   (	PROFILE VARCHAR2(30), 
	PWD_EXPIRE_TIME NUMBER(5,0), 
	PWD_GRACE_TIME NUMBER(5,0), 
	PWD_REUSE_MAX NUMBER(5,0), 
	PWD_REUSE_TIME NUMBER(5,0), 
	PWD_VERIFY_FUNC VARCHAR2(30), 
	PWD_LOCK_TIME NUMBER(10,2), 
	USER_MAX_LOGIN NUMBER(5,0), 
	USER_MAX_SESSION NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_PROFILES ***
 exec bpa.alter_policies('STAFF_PROFILES');


COMMENT ON TABLE BARS.STAFF_PROFILES IS 'Профили пользователей.';
COMMENT ON COLUMN BARS.STAFF_PROFILES.PROFILE IS 'Наименование профиля';
COMMENT ON COLUMN BARS.STAFF_PROFILES.PWD_EXPIRE_TIME IS 'Срок действия пароля в днях';
COMMENT ON COLUMN BARS.STAFF_PROFILES.PWD_GRACE_TIME IS 'Кол-во дней через которое выдается предупреждение о истечении срока действия пароля';
COMMENT ON COLUMN BARS.STAFF_PROFILES.PWD_REUSE_MAX IS 'Максимальное кол-во использований одного пароля';
COMMENT ON COLUMN BARS.STAFF_PROFILES.PWD_REUSE_TIME IS 'Кол-во дней использования одного пароля';
COMMENT ON COLUMN BARS.STAFF_PROFILES.PWD_VERIFY_FUNC IS 'Функция проверки сложности пароля';
COMMENT ON COLUMN BARS.STAFF_PROFILES.PWD_LOCK_TIME IS 'Кол-во дней блокировки входа после превышения допустимого коичества ошибок входа';
COMMENT ON COLUMN BARS.STAFF_PROFILES.USER_MAX_LOGIN IS 'Кол-во попыток входа';
COMMENT ON COLUMN BARS.STAFF_PROFILES.USER_MAX_SESSION IS 'Максимальное кол-во сессий одного пользователя';




PROMPT *** Create  constraint PK_STAFFPROFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_PROFILES ADD CONSTRAINT PK_STAFFPROFILES PRIMARY KEY (PROFILE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFPROFILES_PROFILE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_PROFILES MODIFY (PROFILE CONSTRAINT CC_STAFFPROFILES_PROFILE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFPROFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFPROFILES ON BARS.STAFF_PROFILES (PROFILE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_PROFILES ***
grant SELECT                                                                 on STAFF_PROFILES  to ABS_ADMIN;
grant SELECT                                                                 on STAFF_PROFILES  to BARSREADER_ROLE;
grant SELECT                                                                 on STAFF_PROFILES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_PROFILES  to BARS_DM;
grant SELECT                                                                 on STAFF_PROFILES  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_PROFILES  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_PROFILES.sql =========*** End **
PROMPT ===================================================================================== 
