

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_WORKSPACES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_WORKSPACES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_WORKSPACES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_WORKSPACES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_WORKSPACES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_WORKSPACES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_WORKSPACES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_WORKSPACES ***
 exec bpa.alter_policies('WCS_WORKSPACES');


COMMENT ON TABLE BARS.WCS_WORKSPACES IS 'Рабочие пространства для хранения ответов';
COMMENT ON COLUMN BARS.WCS_WORKSPACES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_WORKSPACES.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_WCSWORKSPACES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_WORKSPACES ADD CONSTRAINT PK_WCSWORKSPACES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSWORKSPACES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_WORKSPACES MODIFY (NAME CONSTRAINT CC_WCSWORKSPACES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSWORKSPACES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSWORKSPACES ON BARS.WCS_WORKSPACES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_WORKSPACES ***
grant SELECT                                                                 on WCS_WORKSPACES  to BARSREADER_ROLE;
grant SELECT                                                                 on WCS_WORKSPACES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_WORKSPACES  to BARS_DM;
grant SELECT                                                                 on WCS_WORKSPACES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_WORKSPACES.sql =========*** End **
PROMPT ===================================================================================== 
