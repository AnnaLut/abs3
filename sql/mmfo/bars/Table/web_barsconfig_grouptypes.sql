

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_BARSCONFIG_GROUPTYPES.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_BARSCONFIG_GROUPTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_BARSCONFIG_GROUPTYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_BARSCONFIG_GROUPTYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''WEB_BARSCONFIG_GROUPTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_BARSCONFIG_GROUPTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_BARSCONFIG_GROUPTYPES 
   (	ID NUMBER, 
	TYPE_NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_BARSCONFIG_GROUPTYPES ***
 exec bpa.alter_policies('WEB_BARSCONFIG_GROUPTYPES');


COMMENT ON TABLE BARS.WEB_BARSCONFIG_GROUPTYPES IS '';
COMMENT ON COLUMN BARS.WEB_BARSCONFIG_GROUPTYPES.ID IS '';
COMMENT ON COLUMN BARS.WEB_BARSCONFIG_GROUPTYPES.TYPE_NAME IS '';




PROMPT *** Create  constraint PK_WEB_BARSCONFIG_GROUPTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_BARSCONFIG_GROUPTYPES ADD CONSTRAINT PK_WEB_BARSCONFIG_GROUPTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008604 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_BARSCONFIG_GROUPTYPES MODIFY (TYPE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WEB_BARSCONFIG_GROUPTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WEB_BARSCONFIG_GROUPTYPES ON BARS.WEB_BARSCONFIG_GROUPTYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_BARSCONFIG_GROUPTYPES ***
grant SELECT                                                                 on WEB_BARSCONFIG_GROUPTYPES to BARSREADER_ROLE;
grant SELECT                                                                 on WEB_BARSCONFIG_GROUPTYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WEB_BARSCONFIG_GROUPTYPES to BARS_DM;
grant SELECT                                                                 on WEB_BARSCONFIG_GROUPTYPES to UPLD;
grant SELECT                                                                 on WEB_BARSCONFIG_GROUPTYPES to WEBTECH;
grant SELECT                                                                 on WEB_BARSCONFIG_GROUPTYPES to WR_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_BARSCONFIG_GROUPTYPES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_BARSCONFIG_GROUPTYPES.sql ========
PROMPT ===================================================================================== 
