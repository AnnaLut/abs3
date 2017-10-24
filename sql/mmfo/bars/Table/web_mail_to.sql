

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_MAIL_TO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_MAIL_TO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_MAIL_TO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_MAIL_TO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_MAIL_TO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_MAIL_TO ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_MAIL_TO 
   (	MAIL_ID NUMBER(38,0), 
	MAIL_RECIPIENT_ID NUMBER(38,0), 
	READED NUMBER(1,0) DEFAULT 0, 
	READED_DATE DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_MAIL_TO ***
 exec bpa.alter_policies('WEB_MAIL_TO');


COMMENT ON TABLE BARS.WEB_MAIL_TO IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_TO.MAIL_ID IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_TO.MAIL_RECIPIENT_ID IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_TO.READED IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_TO.READED_DATE IS '';




PROMPT *** Create  constraint FK_WEBMAILTO_MAILBOX ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_TO ADD CONSTRAINT FK_WEBMAILTO_MAILBOX FOREIGN KEY (MAIL_ID)
	  REFERENCES BARS.WEB_MAIL_BOX (MAIL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WEBMAILTO_MAILFROM ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_TO ADD CONSTRAINT FK_WEBMAILTO_MAILFROM FOREIGN KEY (MAIL_RECIPIENT_ID)
	  REFERENCES BARS.WEB_MAIL_FROM (USER_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBMAILTO_MAILID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_TO MODIFY (MAIL_ID CONSTRAINT CC_WEBMAILTO_MAILID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBMAILTO_RECEPIENTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_TO MODIFY (MAIL_RECIPIENT_ID CONSTRAINT CC_WEBMAILTO_RECEPIENTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBMAILTO_READED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_TO MODIFY (READED CONSTRAINT CC_WEBMAILTO_READED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WEBMAILTO ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_TO ADD CONSTRAINT PK_WEBMAILTO PRIMARY KEY (MAIL_ID, MAIL_RECIPIENT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WEBMAILTO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WEBMAILTO ON BARS.WEB_MAIL_TO (MAIL_ID, MAIL_RECIPIENT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_MAIL_TO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_MAIL_TO     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_MAIL_TO     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_MAIL_TO.sql =========*** End *** =
PROMPT ===================================================================================== 
