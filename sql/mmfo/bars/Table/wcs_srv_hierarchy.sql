

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SRV_HIERARCHY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SRV_HIERARCHY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SRV_HIERARCHY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SRV_HIERARCHY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SRV_HIERARCHY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SRV_HIERARCHY ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SRV_HIERARCHY 
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




PROMPT *** ALTER_POLICIES to WCS_SRV_HIERARCHY ***
 exec bpa.alter_policies('WCS_SRV_HIERARCHY');


COMMENT ON TABLE BARS.WCS_SRV_HIERARCHY IS 'Иерархия служб';
COMMENT ON COLUMN BARS.WCS_SRV_HIERARCHY.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SRV_HIERARCHY.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_SRVHIERARCHY ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SRV_HIERARCHY ADD CONSTRAINT PK_SRVHIERARCHY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SRVHIERARCHY_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SRV_HIERARCHY MODIFY (NAME CONSTRAINT CC_SRVHIERARCHY_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SRVHIERARCHY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SRVHIERARCHY ON BARS.WCS_SRV_HIERARCHY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SRV_HIERARCHY ***
grant SELECT                                                                 on WCS_SRV_HIERARCHY to BARSREADER_ROLE;
grant SELECT                                                                 on WCS_SRV_HIERARCHY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SRV_HIERARCHY to BARS_DM;
grant SELECT                                                                 on WCS_SRV_HIERARCHY to START1;
grant SELECT                                                                 on WCS_SRV_HIERARCHY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SRV_HIERARCHY.sql =========*** End
PROMPT ===================================================================================== 
