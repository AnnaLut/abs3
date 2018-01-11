

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_MAIL_USER_GROUPS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_MAIL_USER_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_MAIL_USER_GROUPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_MAIL_USER_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_MAIL_USER_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_MAIL_USER_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_MAIL_USER_GROUPS 
   (	GROUP_ID NUMBER(38,0), 
	NAME VARCHAR2(70), 
	ADMIN NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_MAIL_USER_GROUPS ***
 exec bpa.alter_policies('WEB_MAIL_USER_GROUPS');


COMMENT ON TABLE BARS.WEB_MAIL_USER_GROUPS IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_USER_GROUPS.GROUP_ID IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_USER_GROUPS.NAME IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_USER_GROUPS.ADMIN IS '';




PROMPT *** Create  constraint PK_WEBMAILUSER_GROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_USER_GROUPS ADD CONSTRAINT PK_WEBMAILUSER_GROUPS PRIMARY KEY (GROUP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBMAILGROUPS_GROUPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_USER_GROUPS MODIFY (GROUP_ID CONSTRAINT CC_WEBMAILGROUPS_GROUPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBMAILGROUPS_ADMIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_USER_GROUPS MODIFY (ADMIN CONSTRAINT CC_WEBMAILGROUPS_ADMIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WEBMAILUSER_GROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WEBMAILUSER_GROUPS ON BARS.WEB_MAIL_USER_GROUPS (GROUP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_MAIL_USER_GROUPS ***
grant SELECT                                                                 on WEB_MAIL_USER_GROUPS to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_MAIL_USER_GROUPS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_MAIL_USER_GROUPS to START1;
grant SELECT                                                                 on WEB_MAIL_USER_GROUPS to UPLD;
grant FLASHBACK,SELECT                                                       on WEB_MAIL_USER_GROUPS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_MAIL_USER_GROUPS.sql =========*** 
PROMPT ===================================================================================== 
