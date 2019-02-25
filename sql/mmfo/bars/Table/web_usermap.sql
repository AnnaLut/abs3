

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_USERMAP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_USERMAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_USERMAP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_USERMAP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_USERMAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_USERMAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_USERMAP 
   (	WEBUSER VARCHAR2(30), 
	DBUSER VARCHAR2(30), 
	ERRMODE NUMBER(*,0) DEFAULT 0, 
	WEBPASS VARCHAR2(60), 
	ADMINPASS VARCHAR2(60), 
	COMM VARCHAR2(256), 
	CHGDATE DATE, 
	BLOCKED NUMBER(1,0) DEFAULT 0, 
	ATTEMPTS NUMBER(2,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_USERMAP ***
 exec bpa.alter_policies('WEB_USERMAP');


COMMENT ON TABLE BARS.WEB_USERMAP IS '';
COMMENT ON COLUMN BARS.WEB_USERMAP.WEBUSER IS '';
COMMENT ON COLUMN BARS.WEB_USERMAP.DBUSER IS '';
COMMENT ON COLUMN BARS.WEB_USERMAP.ERRMODE IS '';
COMMENT ON COLUMN BARS.WEB_USERMAP.WEBPASS IS '';
COMMENT ON COLUMN BARS.WEB_USERMAP.ADMINPASS IS '';
COMMENT ON COLUMN BARS.WEB_USERMAP.COMM IS '';
COMMENT ON COLUMN BARS.WEB_USERMAP.CHGDATE IS '';
COMMENT ON COLUMN BARS.WEB_USERMAP.BLOCKED IS '';
COMMENT ON COLUMN BARS.WEB_USERMAP.ATTEMPTS IS '';




PROMPT *** Create  constraint PK_WEB_USERMAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_USERMAP ADD CONSTRAINT PK_WEB_USERMAP PRIMARY KEY (WEBUSER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBUSERMAP_PASS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_USERMAP ADD CONSTRAINT CC_WEBUSERMAP_PASS CHECK ((WEBPASS is null and ADMINPASS is not null ) or (WEBPASS is not null and ADMINPASS is null)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBUSERMAP_DBUSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_USERMAP MODIFY (DBUSER CONSTRAINT CC_WEBUSERMAP_DBUSER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEBUSERMAP_ERRMODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_USERMAP MODIFY (ERRMODE CONSTRAINT CC_WEBUSERMAP_ERRMODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WEB_USERMAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WEB_USERMAP ON BARS.WEB_USERMAP (WEBUSER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_WEB_USERMAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_WEB_USERMAP ON BARS.WEB_USERMAP (LOWER(WEBUSER)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  WEB_USERMAP ***
grant SELECT                                                                 on WEB_USERMAP     to BARSREADER_ROLE;
grant SELECT                                                                 on WEB_USERMAP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WEB_USERMAP     to BARS_DM;
grant SELECT                                                                 on WEB_USERMAP     to UPLD;
grant SELECT                                                                 on WEB_USERMAP     to WEBTECH;
grant SELECT                                                                 on WEB_USERMAP     to WR_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_USERMAP     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_USERMAP.sql =========*** End *** =
PROMPT ===================================================================================== 
