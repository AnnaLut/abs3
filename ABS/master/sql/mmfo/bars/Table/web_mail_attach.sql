

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_MAIL_ATTACH.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_MAIL_ATTACH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_MAIL_ATTACH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_MAIL_ATTACH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_MAIL_ATTACH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_MAIL_ATTACH ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_MAIL_ATTACH 
   (	MAIL_ID NUMBER(38,0), 
	ATTACH_ID NUMBER(38,0), 
	FILE_NAME VARCHAR2(70), 
	ATTACHMENT BLOB, 
	ATTACH_SIZE NUMBER(38,0), 
	ATTACH_SIGN VARCHAR2(128)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (ATTACHMENT) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_MAIL_ATTACH ***
 exec bpa.alter_policies('WEB_MAIL_ATTACH');


COMMENT ON TABLE BARS.WEB_MAIL_ATTACH IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_ATTACH.MAIL_ID IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_ATTACH.ATTACH_ID IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_ATTACH.FILE_NAME IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_ATTACH.ATTACHMENT IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_ATTACH.ATTACH_SIZE IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_ATTACH.ATTACH_SIGN IS '';




PROMPT *** Create  constraint PK_WEBMAILATTACH ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_ATTACH ADD CONSTRAINT PK_WEBMAILATTACH PRIMARY KEY (MAIL_ID, ATTACH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBMAILATTACH_MAILID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_ATTACH MODIFY (MAIL_ID CONSTRAINT CC_WEBMAILATTACH_MAILID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBMAILATTACH_ATTACHID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_ATTACH MODIFY (ATTACH_ID CONSTRAINT CC_WEBMAILATTACH_ATTACHID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WEBMAILATTACH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WEBMAILATTACH ON BARS.WEB_MAIL_ATTACH (MAIL_ID, ATTACH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_MAIL_ATTACH ***
grant SELECT                                                                 on WEB_MAIL_ATTACH to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_MAIL_ATTACH to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_MAIL_ATTACH to START1;
grant SELECT                                                                 on WEB_MAIL_ATTACH to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_MAIL_ATTACH.sql =========*** End *
PROMPT ===================================================================================== 
