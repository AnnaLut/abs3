

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_FKPRIORITY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_FKPRIORITY ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_FKPRIORITY 
   (	FK_PRIORITY_ID NUMBER, 
	DESCRIPT VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_FKPRIORITY IS '';
COMMENT ON COLUMN BARSUPL.UPL_FKPRIORITY.FK_PRIORITY_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_FKPRIORITY.DESCRIPT IS '';




PROMPT *** Create  constraint PK_UPLFKPRIORITY ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FKPRIORITY ADD CONSTRAINT PK_UPLFKPRIORITY PRIMARY KEY (FK_PRIORITY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLFKPRIORITY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLFKPRIORITY ON BARSUPL.UPL_FKPRIORITY (FK_PRIORITY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_FKPRIORITY ***
grant SELECT                                                                 on UPL_FKPRIORITY  to BARSREADER_ROLE;
grant SELECT                                                                 on UPL_FKPRIORITY  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_FKPRIORITY.sql =========*** End
PROMPT ===================================================================================== 
