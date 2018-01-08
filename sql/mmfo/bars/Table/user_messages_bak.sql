

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/USER_MESSAGES_BAK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to USER_MESSAGES_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table USER_MESSAGES_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.USER_MESSAGES_BAK 
   (	MSG_ID NUMBER(38,0), 
	USER_ID NUMBER(38,0), 
	MSG_TYPE_ID NUMBER(38,0), 
	MSG_SENDER_ID NUMBER(38,0), 
	MSG_SUBJECT VARCHAR2(256), 
	MSG_TEXT VARCHAR2(4000), 
	MSG_DATE DATE, 
	MSG_ACT_DATE DATE, 
	MSG_DONE NUMBER(1,0), 
	USER_COMMENT VARCHAR2(512), 
	MSG_DONE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to USER_MESSAGES_BAK ***
 exec bpa.alter_policies('USER_MESSAGES_BAK');


COMMENT ON TABLE BARS.USER_MESSAGES_BAK IS 'Повідомлення WEB користувачів';
COMMENT ON COLUMN BARS.USER_MESSAGES_BAK.MSG_ID IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BAK.USER_ID IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BAK.MSG_TYPE_ID IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BAK.MSG_SENDER_ID IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BAK.MSG_SUBJECT IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BAK.MSG_TEXT IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BAK.MSG_DATE IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BAK.MSG_ACT_DATE IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BAK.MSG_DONE IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BAK.USER_COMMENT IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BAK.MSG_DONE_DATE IS 'Дата підтвердження про прочитання';




PROMPT *** Create  constraint CC_USERMESSAGES_MSGDONE ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_BAK ADD CONSTRAINT CC_USERMESSAGES_MSGDONE CHECK (msg_done in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_USERMESSAGES ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_BAK ADD CONSTRAINT PK_USERMESSAGES PRIMARY KEY (MSG_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERMESSAGES_MSGDONE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_BAK MODIFY (MSG_DONE CONSTRAINT CC_USERMESSAGES_MSGDONE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERMESSAGES_MSGACTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_BAK MODIFY (MSG_ACT_DATE CONSTRAINT CC_USERMESSAGES_MSGACTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERMESSAGES_MSGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_BAK MODIFY (MSG_DATE CONSTRAINT CC_USERMESSAGES_MSGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERMESSAGES_MSGTEXT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_BAK MODIFY (MSG_TEXT CONSTRAINT CC_USERMESSAGES_MSGTEXT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERMESSAGES_MSGSUBJ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_BAK MODIFY (MSG_SUBJECT CONSTRAINT CC_USERMESSAGES_MSGSUBJ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERMESSAGES_MSGSENDERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_BAK MODIFY (MSG_SENDER_ID CONSTRAINT CC_USERMESSAGES_MSGSENDERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERMESSAGES_MSGTYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_BAK MODIFY (MSG_TYPE_ID CONSTRAINT CC_USERMESSAGES_MSGTYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERMESSAGES_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_BAK MODIFY (USER_ID CONSTRAINT CC_USERMESSAGES_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_USERMESSAGES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_USERMESSAGES ON BARS.USER_MESSAGES_BAK (MSG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  USER_MESSAGES_BAK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on USER_MESSAGES_BAK to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on USER_MESSAGES_BAK to DPT_ADMIN;
grant SELECT                                                                 on USER_MESSAGES_BAK to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on USER_MESSAGES_BAK to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/USER_MESSAGES_BAK.sql =========*** End
PROMPT ===================================================================================== 
