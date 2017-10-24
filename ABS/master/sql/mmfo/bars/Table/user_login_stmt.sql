

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/USER_LOGIN_STMT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to USER_LOGIN_STMT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''USER_LOGIN_STMT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''USER_LOGIN_STMT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''USER_LOGIN_STMT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table USER_LOGIN_STMT ***
begin 
  execute immediate '
  CREATE TABLE BARS.USER_LOGIN_STMT 
   (	ID NUMBER(38,0), 
	EXEC NUMBER(1,0) DEFAULT 1, 
	STMT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to USER_LOGIN_STMT ***
 exec bpa.alter_policies('USER_LOGIN_STMT');


COMMENT ON TABLE BARS.USER_LOGIN_STMT IS 'PL/SQL-блоки, выполняемые после логина';
COMMENT ON COLUMN BARS.USER_LOGIN_STMT.ID IS 'ID пользователя';
COMMENT ON COLUMN BARS.USER_LOGIN_STMT.EXEC IS '1/0 - вкл/выкл';
COMMENT ON COLUMN BARS.USER_LOGIN_STMT.STMT IS 'PL/SQL блок';




PROMPT *** Create  constraint FK_USERLOGINSTMT_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_LOGIN_STMT ADD CONSTRAINT FK_USERLOGINSTMT_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERLOGINSTMT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_LOGIN_STMT MODIFY (ID CONSTRAINT CC_USERLOGINSTMT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERLOGINSTMT_EXEC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_LOGIN_STMT MODIFY (EXEC CONSTRAINT CC_USERLOGINSTMT_EXEC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERLOGINSTMT_EXEC ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_LOGIN_STMT ADD CONSTRAINT CC_USERLOGINSTMT_EXEC CHECK (exec in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_USERLOGINSTMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_LOGIN_STMT ADD CONSTRAINT PK_USERLOGINSTMT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_USERLOGINSTMT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_USERLOGINSTMT ON BARS.USER_LOGIN_STMT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  USER_LOGIN_STMT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on USER_LOGIN_STMT to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on USER_LOGIN_STMT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on USER_LOGIN_STMT to BARS_DM;
grant SELECT                                                                 on USER_LOGIN_STMT to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on USER_LOGIN_STMT to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on USER_LOGIN_STMT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/USER_LOGIN_STMT.sql =========*** End *
PROMPT ===================================================================================== 
