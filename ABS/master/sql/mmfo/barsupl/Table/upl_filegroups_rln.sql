

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_FILEGROUPS_RLN.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_FILEGROUPS_RLN ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_FILEGROUPS_RLN 
   (	GROUP_ID NUMBER, 
	FILE_ID NUMBER, 
	SQL_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_FILEGROUPS_RLN IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILEGROUPS_RLN.GROUP_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILEGROUPS_RLN.FILE_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_FILEGROUPS_RLN.SQL_ID IS '';




PROMPT *** Create  constraint FK_FILESID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILEGROUPS_RLN ADD CONSTRAINT FK_FILESID FOREIGN KEY (FILE_ID)
	  REFERENCES BARSUPL.UPL_FILES (FILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SQLID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILEGROUPS_RLN ADD CONSTRAINT FK_SQLID FOREIGN KEY (SQL_ID)
	  REFERENCES BARSUPL.UPL_SQL (SQL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GROUPID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILEGROUPS_RLN ADD CONSTRAINT FK_GROUPID FOREIGN KEY (GROUP_ID)
	  REFERENCES BARSUPL.UPL_GROUPS (GROUP_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_UPLFILEGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILEGROUPS_RLN ADD CONSTRAINT PK_UPLFILEGROUPS PRIMARY KEY (GROUP_ID, FILE_ID, SQL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLFILEGROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLFILEGROUPS ON BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_FILEGROUPS_RLN ***
grant SELECT                                                                 on UPL_FILEGROUPS_RLN to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_FILEGROUPS_RLN.sql =========***
PROMPT ===================================================================================== 
