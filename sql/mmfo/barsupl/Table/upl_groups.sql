

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_GROUPS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_GROUPS 
   (	GROUP_ID NUMBER, 
	DESCRIPT VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_GROUPS IS '';
COMMENT ON COLUMN BARSUPL.UPL_GROUPS.GROUP_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_GROUPS.DESCRIPT IS '';




PROMPT *** Create  constraint PK_UPLGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_GROUPS ADD CONSTRAINT PK_UPLGROUPS PRIMARY KEY (GROUP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLGROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLGROUPS ON BARSUPL.UPL_GROUPS (GROUP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_GROUPS ***
grant SELECT                                                                 on UPL_GROUPS      to BARS with grant option;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_GROUPS.sql =========*** End ***
PROMPT ===================================================================================== 
