

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_BARSCONFIG.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_BARSCONFIG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_BARSCONFIG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_BARSCONFIG'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''WEB_BARSCONFIG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_BARSCONFIG ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_BARSCONFIG 
   (	GROUPTYPE NUMBER, 
	KEY VARCHAR2(100), 
	CSHARPTYPE VARCHAR2(30), 
	VAL VARCHAR2(1024), 
	COMM VARCHAR2(1024)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_BARSCONFIG ***
 exec bpa.alter_policies('WEB_BARSCONFIG');


COMMENT ON TABLE BARS.WEB_BARSCONFIG IS '';
COMMENT ON COLUMN BARS.WEB_BARSCONFIG.GROUPTYPE IS '';
COMMENT ON COLUMN BARS.WEB_BARSCONFIG.KEY IS '';
COMMENT ON COLUMN BARS.WEB_BARSCONFIG.CSHARPTYPE IS '';
COMMENT ON COLUMN BARS.WEB_BARSCONFIG.VAL IS '';
COMMENT ON COLUMN BARS.WEB_BARSCONFIG.COMM IS '';




PROMPT *** Create  constraint FK_WEB_BARSCONFIG_GROUPTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_BARSCONFIG ADD CONSTRAINT FK_WEB_BARSCONFIG_GROUPTYPE FOREIGN KEY (GROUPTYPE)
	  REFERENCES BARS.WEB_BARSCONFIG_GROUPTYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WEB_BARSCONFIG ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_BARSCONFIG ADD CONSTRAINT PK_WEB_BARSCONFIG PRIMARY KEY (KEY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WEB_BARSCONFIG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WEB_BARSCONFIG ON BARS.WEB_BARSCONFIG (KEY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_BARSCONFIG ***
grant SELECT                                                                 on WEB_BARSCONFIG  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WEB_BARSCONFIG  to BARS_DM;
grant SELECT                                                                 on WEB_BARSCONFIG  to WEBTECH;
grant SELECT                                                                 on WEB_BARSCONFIG  to WR_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_BARSCONFIG  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_BARSCONFIG.sql =========*** End **
PROMPT ===================================================================================== 
