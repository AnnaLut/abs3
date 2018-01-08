

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_TASK_GROUPS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMS_TASK_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_TASK_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMS_TASK_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMS_TASK_GROUPS 
   (	ID_GROUP NUMBER(*,0), 
	NAME_GROUP VARCHAR2(50), 
	UI_MEMBERS VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMS_TASK_GROUPS ***
 exec bpa.alter_policies('TMS_TASK_GROUPS');


COMMENT ON TABLE BARS.TMS_TASK_GROUPS IS '';
COMMENT ON COLUMN BARS.TMS_TASK_GROUPS.ID_GROUP IS '';
COMMENT ON COLUMN BARS.TMS_TASK_GROUPS.NAME_GROUP IS '';
COMMENT ON COLUMN BARS.TMS_TASK_GROUPS.UI_MEMBERS IS '';




PROMPT *** Create  constraint PK_ID_GROUP ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMS_TASK_GROUPS ADD CONSTRAINT PK_ID_GROUP PRIMARY KEY (ID_GROUP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ID_GROUP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ID_GROUP ON BARS.TMS_TASK_GROUPS (ID_GROUP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMS_TASK_GROUPS ***
grant SELECT                                                                 on TMS_TASK_GROUPS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_TASK_GROUPS.sql =========*** End *
PROMPT ===================================================================================== 
