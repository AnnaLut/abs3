

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_PROFILE_PARAMS_FOR_JOB.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_PROFILE_PARAMS_FOR_JOB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_PROFILE_PARAMS_FOR_JOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_PROFILE_PARAMS_FOR_JOB 
   (	JOB NUMBER, 
	TAG VARCHAR2(30), 
	VALUE VARCHAR2(255), 
	USER_NAME VARCHAR2(30), 
	USER_ID NUMBER, 
	PROFILE_NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_PROFILE_PARAMS_FOR_JOB ***
 exec bpa.alter_policies('WEB_PROFILE_PARAMS_FOR_JOB');


COMMENT ON TABLE BARS.WEB_PROFILE_PARAMS_FOR_JOB IS 'WEB PROFILES: Параметры задания для работы jobов';
COMMENT ON COLUMN BARS.WEB_PROFILE_PARAMS_FOR_JOB.JOB IS 'Номер задания';
COMMENT ON COLUMN BARS.WEB_PROFILE_PARAMS_FOR_JOB.TAG IS 'Тег параметра';
COMMENT ON COLUMN BARS.WEB_PROFILE_PARAMS_FOR_JOB.VALUE IS 'Значение параметра';
COMMENT ON COLUMN BARS.WEB_PROFILE_PARAMS_FOR_JOB.USER_NAME IS 'Имя пользователя';
COMMENT ON COLUMN BARS.WEB_PROFILE_PARAMS_FOR_JOB.USER_ID IS 'Идентификатор пользователя';
COMMENT ON COLUMN BARS.WEB_PROFILE_PARAMS_FOR_JOB.PROFILE_NAME IS 'Профиль пользователя';




PROMPT *** Create  constraint XPK_WEB_PROFILE_PARAMS_FOR_JOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_PROFILE_PARAMS_FOR_JOB ADD CONSTRAINT XPK_WEB_PROFILE_PARAMS_FOR_JOB PRIMARY KEY (JOB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_WEB_PROFILE_PARAMS_FOR_JOB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_WEB_PROFILE_PARAMS_FOR_JOB ON BARS.WEB_PROFILE_PARAMS_FOR_JOB (JOB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_PROFILE_PARAMS_FOR_JOB ***
grant SELECT                                                                 on WEB_PROFILE_PARAMS_FOR_JOB to BARSREADER_ROLE;
grant SELECT                                                                 on WEB_PROFILE_PARAMS_FOR_JOB to BARS_DM;
grant SELECT                                                                 on WEB_PROFILE_PARAMS_FOR_JOB to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_PROFILE_PARAMS_FOR_JOB to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to WEB_PROFILE_PARAMS_FOR_JOB ***

  CREATE OR REPLACE PUBLIC SYNONYM WEB_PROFILE_PARAMS_FOR_JOB FOR BARS.WEB_PROFILE_PARAMS_FOR_JOB;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_PROFILE_PARAMS_FOR_JOB.sql =======
PROMPT ===================================================================================== 
