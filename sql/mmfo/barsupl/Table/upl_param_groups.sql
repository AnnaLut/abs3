

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_PARAM_GROUPS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_PARAM_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_PARAM_GROUPS 
   (	GROUP_ID NUMBER, 
	GROUP_NAME VARCHAR2(200), 
	ISSYSTEM NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_PARAM_GROUPS IS '';
COMMENT ON COLUMN BARSUPL.UPL_PARAM_GROUPS.GROUP_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_PARAM_GROUPS.GROUP_NAME IS '';
COMMENT ON COLUMN BARSUPL.UPL_PARAM_GROUPS.ISSYSTEM IS '';




PROMPT *** Create  constraint PK_UPLPARAMGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_PARAM_GROUPS ADD CONSTRAINT PK_UPLPARAMGROUPS PRIMARY KEY (GROUP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLPARAMGROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLPARAMGROUPS ON BARSUPL.UPL_PARAM_GROUPS (GROUP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_PARAM_GROUPS ***
grant SELECT                                                                 on UPL_PARAM_GROUPS to BARS;
grant SELECT                                                                 on UPL_PARAM_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on UPL_PARAM_GROUPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_PARAM_GROUPS.sql =========*** E
PROMPT ===================================================================================== 
