

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_MAIL_FROM.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_MAIL_FROM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_MAIL_FROM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_MAIL_FROM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_MAIL_FROM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_MAIL_FROM ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_MAIL_FROM 
   (	USER_ID NUMBER, 
	GROUP_ID NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_MAIL_FROM ***
 exec bpa.alter_policies('WEB_MAIL_FROM');


COMMENT ON TABLE BARS.WEB_MAIL_FROM IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_FROM.USER_ID IS '';
COMMENT ON COLUMN BARS.WEB_MAIL_FROM.GROUP_ID IS '';




PROMPT *** Create  constraint PK_WEBMAILFROM ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_FROM ADD CONSTRAINT PK_WEBMAILFROM PRIMARY KEY (USER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBMAILFROM_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_FROM MODIFY (USER_ID CONSTRAINT CC_WEBMAILFROM_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBMAILFROM_GROUPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_FROM MODIFY (GROUP_ID CONSTRAINT CC_WEBMAILFROM_GROUPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WEBMAILFROM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WEBMAILFROM ON BARS.WEB_MAIL_FROM (USER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_MAIL_FROM ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_MAIL_FROM   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_MAIL_FROM   to START1;
grant FLASHBACK,SELECT                                                       on WEB_MAIL_FROM   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_MAIL_FROM.sql =========*** End ***
PROMPT ===================================================================================== 
