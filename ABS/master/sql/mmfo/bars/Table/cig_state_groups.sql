

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_STATE_GROUPS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_STATE_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_STATE_GROUPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_STATE_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_STATE_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_STATE_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_STATE_GROUPS 
   (	GROUP_ID NUMBER(4,0), 
	GROUP_NAME VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_STATE_GROUPS ***
 exec bpa.alter_policies('CIG_STATE_GROUPS');


COMMENT ON TABLE BARS.CIG_STATE_GROUPS IS 'Довідник стану зібраних даних';
COMMENT ON COLUMN BARS.CIG_STATE_GROUPS.GROUP_ID IS 'Код групи';
COMMENT ON COLUMN BARS.CIG_STATE_GROUPS.GROUP_NAME IS 'Група';




PROMPT *** Create  constraint PK_CIGSTATEGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_STATE_GROUPS ADD CONSTRAINT PK_CIGSTATEGROUPS PRIMARY KEY (GROUP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGSTATEGROUPS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_STATE_GROUPS MODIFY (GROUP_NAME CONSTRAINT CC_CIGSTATEGROUPS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGSTATEGROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGSTATEGROUPS ON BARS.CIG_STATE_GROUPS (GROUP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_STATE_GROUPS ***
grant SELECT                                                                 on CIG_STATE_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_STATE_GROUPS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_STATE_GROUPS.sql =========*** End 
PROMPT ===================================================================================== 
