

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_GROUPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_GROUPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_GROUPS 
   (	GROUP_ID NUMBER(4,0), 
	GROUP_NAME VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_GROUPS ***
 exec bpa.alter_policies('GRT_GROUPS');


COMMENT ON TABLE BARS.GRT_GROUPS IS 'Таблица групп видов обеспечения';
COMMENT ON COLUMN BARS.GRT_GROUPS.GROUP_ID IS 'Идетнификатор вида обеспечения';
COMMENT ON COLUMN BARS.GRT_GROUPS.GROUP_NAME IS 'Наименование вида обеспечения';




PROMPT *** Create  constraint PK_GRTGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_GROUPS ADD CONSTRAINT PK_GRTGROUPS PRIMARY KEY (GROUP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTGROUPS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_GROUPS MODIFY (GROUP_NAME CONSTRAINT CC_GRTGROUPS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTGROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTGROUPS ON BARS.GRT_GROUPS (GROUP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_GROUPS ***
grant SELECT                                                                 on GRT_GROUPS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_GROUPS      to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_GROUPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
