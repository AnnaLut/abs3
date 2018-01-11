

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_MAIL_BOX.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_MAIL_BOX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_MAIL_BOX'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_MAIL_BOX'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_MAIL_BOX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_MAIL_BOX ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_MAIL_BOX 
   (	MAIL_ID NUMBER(38,0), 
	MAIL_SENDER_ID NUMBER(38,0), 
	MAIL_SUBJECT VARCHAR2(70), 
	MAIL_BODY VARCHAR2(4000), 
	MAIL_DATE DATE DEFAULT sysdate
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_MAIL_BOX ***
 exec bpa.alter_policies('WEB_MAIL_BOX');


COMMENT ON TABLE BARS.WEB_MAIL_BOX IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_BOX.MAIL_ID IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_BOX.MAIL_SENDER_ID IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_BOX.MAIL_SUBJECT IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_BOX.MAIL_BODY IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_BOX.MAIL_DATE IS '';




PROMPT *** Create  constraint CC_WEBMAILBOX_MAILID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_BOX MODIFY (MAIL_ID CONSTRAINT CC_WEBMAILBOX_MAILID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WEBMAILBOX ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_BOX ADD CONSTRAINT PK_WEBMAILBOX PRIMARY KEY (MAIL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WEBMAILBOX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WEBMAILBOX ON BARS.WEB_MAIL_BOX (MAIL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_MAIL_BOX ***
grant SELECT                                                                 on WEB_MAIL_BOX    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_MAIL_BOX    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_MAIL_BOX    to START1;
grant SELECT                                                                 on WEB_MAIL_BOX    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_MAIL_BOX.sql =========*** End *** 
PROMPT ===================================================================================== 
