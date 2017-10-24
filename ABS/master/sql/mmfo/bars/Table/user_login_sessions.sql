

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/USER_LOGIN_SESSIONS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to USER_LOGIN_SESSIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''USER_LOGIN_SESSIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''USER_LOGIN_SESSIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''USER_LOGIN_SESSIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table USER_LOGIN_SESSIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.USER_LOGIN_SESSIONS 
   (	CLIENT_ID VARCHAR2(64), 
	USER_ID NUMBER(38,0), 
	PROXY_USER VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to USER_LOGIN_SESSIONS ***
 exec bpa.alter_policies('USER_LOGIN_SESSIONS');


COMMENT ON TABLE BARS.USER_LOGIN_SESSIONS IS '';
COMMENT ON COLUMN BARS.USER_LOGIN_SESSIONS.CLIENT_ID IS '';
COMMENT ON COLUMN BARS.USER_LOGIN_SESSIONS.USER_ID IS '';
COMMENT ON COLUMN BARS.USER_LOGIN_SESSIONS.PROXY_USER IS '';




PROMPT *** Create  constraint CC_USERLOGINSESS_CLIID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_LOGIN_SESSIONS MODIFY (CLIENT_ID CONSTRAINT CC_USERLOGINSESS_CLIID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERLOGINSESS_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_LOGIN_SESSIONS MODIFY (USER_ID CONSTRAINT CC_USERLOGINSESS_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_USER_LOGIN_SESSION ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_USER_LOGIN_SESSION ON BARS.USER_LOGIN_SESSIONS (CLIENT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_LOGIN_SESSION_USER_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_LOGIN_SESSION_USER_ID ON BARS.USER_LOGIN_SESSIONS (USER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  USER_LOGIN_SESSIONS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on USER_LOGIN_SESSIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on USER_LOGIN_SESSIONS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on USER_LOGIN_SESSIONS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/USER_LOGIN_SESSIONS.sql =========*** E
PROMPT ===================================================================================== 
