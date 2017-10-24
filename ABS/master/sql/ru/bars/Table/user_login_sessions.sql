

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/USER_LOGIN_SESSIONS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to USER_LOGIN_SESSIONS ***


BEGIN 
        execute immediate  
          'begin  
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




PROMPT *** Create  constraint PK_USERLOGINSESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_LOGIN_SESSIONS ADD CONSTRAINT PK_USERLOGINSESS PRIMARY KEY (CLIENT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
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




PROMPT *** Create  constraint CC_USERLOGINSESS_CLIID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_LOGIN_SESSIONS MODIFY (CLIENT_ID CONSTRAINT CC_USERLOGINSESS_CLIID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_USERLOGINSESS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_USERLOGINSESS ON BARS.USER_LOGIN_SESSIONS (CLIENT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/USER_LOGIN_SESSIONS.sql =========*** E
PROMPT ===================================================================================== 
