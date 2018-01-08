

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/USER_MESSAGES_BARSNOTIFY.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to USER_MESSAGES_BARSNOTIFY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''USER_MESSAGES_BARSNOTIFY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''USER_MESSAGES_BARSNOTIFY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''USER_MESSAGES_BARSNOTIFY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table USER_MESSAGES_BARSNOTIFY ***
begin 
  execute immediate '
  CREATE TABLE BARS.USER_MESSAGES_BARSNOTIFY 
   (	ID NUMBER(10,0), 
	SENDER_ID NUMBER(10,0), 
	RECEIVER_SID NUMBER, 
	RECEIVER_LOGIN_NAME VARCHAR2(30 CHAR), 
	MESSAGE_DATE DATE, 
	MESSAGE_TEXT VARCHAR2(4000), 
	SENDING_TIME DATE, 
	EXPIRATION_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to USER_MESSAGES_BARSNOTIFY ***
 exec bpa.alter_policies('USER_MESSAGES_BARSNOTIFY');


COMMENT ON TABLE BARS.USER_MESSAGES_BARSNOTIFY IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BARSNOTIFY.ID IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BARSNOTIFY.SENDER_ID IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BARSNOTIFY.RECEIVER_SID IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BARSNOTIFY.RECEIVER_LOGIN_NAME IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BARSNOTIFY.MESSAGE_DATE IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BARSNOTIFY.MESSAGE_TEXT IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BARSNOTIFY.SENDING_TIME IS '';
COMMENT ON COLUMN BARS.USER_MESSAGES_BARSNOTIFY.EXPIRATION_TIME IS '';




PROMPT *** Create  constraint PK_USER_MESSAGES_BARSNOTIFY ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_BARSNOTIFY ADD CONSTRAINT PK_USER_MESSAGES_BARSNOTIFY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_USER_MESSAGES_BARSNOTIFY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_USER_MESSAGES_BARSNOTIFY ON BARS.USER_MESSAGES_BARSNOTIFY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index USER_MESSAGES_BARSNOTIFY_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.USER_MESSAGES_BARSNOTIFY_IDX ON BARS.USER_MESSAGES_BARSNOTIFY (RECEIVER_SID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  USER_MESSAGES_BARSNOTIFY ***
grant SELECT                                                                 on USER_MESSAGES_BARSNOTIFY to BARSREADER_ROLE;
grant SELECT                                                                 on USER_MESSAGES_BARSNOTIFY to BARS_DM;
grant SELECT                                                                 on USER_MESSAGES_BARSNOTIFY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/USER_MESSAGES_BARSNOTIFY.sql =========
PROMPT ===================================================================================== 
