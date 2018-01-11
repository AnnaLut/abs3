

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SWI_PASSP_MAP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SWI_PASSP_MAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SWI_PASSP_MAP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SWI_PASSP_MAP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SWI_PASSP_MAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SWI_PASSP_MAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SWI_PASSP_MAP 
   (	DOC_NAME VARCHAR2(256), 
	MAP_PASSP_ID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SWI_PASSP_MAP ***
 exec bpa.alter_policies('SWI_PASSP_MAP');


COMMENT ON TABLE BARS.SWI_PASSP_MAP IS 'Соответствие значений типа документа';
COMMENT ON COLUMN BARS.SWI_PASSP_MAP.DOC_NAME IS 'Документ из Профикса';
COMMENT ON COLUMN BARS.SWI_PASSP_MAP.MAP_PASSP_ID IS 'ID вида документа из passp';




PROMPT *** Create  constraint CC_SWIPASSP_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_PASSP_MAP MODIFY (DOC_NAME CONSTRAINT CC_SWIPASSP_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWIPASSP_PASSP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_PASSP_MAP MODIFY (MAP_PASSP_ID CONSTRAINT CC_SWIPASSP_PASSP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWIPASSPMAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SWI_PASSP_MAP ADD CONSTRAINT PK_SWIPASSPMAP PRIMARY KEY (DOC_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWIPASSPMAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWIPASSPMAP ON BARS.SWI_PASSP_MAP (DOC_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SWI_PASSP_MAP ***
grant SELECT                                                                 on SWI_PASSP_MAP   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SWI_PASSP_MAP   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SWI_PASSP_MAP   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SWI_PASSP_MAP   to START1;
grant SELECT                                                                 on SWI_PASSP_MAP   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SWI_PASSP_MAP.sql =========*** End ***
PROMPT ===================================================================================== 
