

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_CONS_COLUMNS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_CONS_COLUMNS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_CONS_COLUMNS 
   (	FILE_ID NUMBER, 
	CONSTR_NAME VARCHAR2(250), 
	FK_COLID NUMBER, 
	FK_COLNAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_CONS_COLUMNS IS '';
COMMENT ON COLUMN BARSUPL.UPL_CONS_COLUMNS.FILE_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_CONS_COLUMNS.CONSTR_NAME IS '';
COMMENT ON COLUMN BARSUPL.UPL_CONS_COLUMNS.FK_COLID IS '';
COMMENT ON COLUMN BARSUPL.UPL_CONS_COLUMNS.FK_COLNAME IS '';




PROMPT *** Create  constraint PK_UPLCONSCOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CONS_COLUMNS ADD CONSTRAINT PK_UPLCONSCOLUMNS PRIMARY KEY (FILE_ID, CONSTR_NAME, FK_COLNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLCONSCOLUMNS_FILEID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CONS_COLUMNS ADD CONSTRAINT FK_UPLCONSCOLUMNS_FILEID FOREIGN KEY (FILE_ID, CONSTR_NAME)
	  REFERENCES BARSUPL.UPL_CONSTRAINTS (FILE_ID, CONSTR_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLCONSCOLUMNS_FILEIDCOLN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CONS_COLUMNS ADD CONSTRAINT FK_UPLCONSCOLUMNS_FILEIDCOLN FOREIGN KEY (FILE_ID, FK_COLNAME)
	  REFERENCES BARSUPL.UPL_COLUMNS (FILE_ID, COL_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLCONSCOLUMNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLCONSCOLUMNS ON BARSUPL.UPL_CONS_COLUMNS (FILE_ID, CONSTR_NAME, FK_COLNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_CONS_COLUMNS.sql =========*** E
PROMPT ===================================================================================== 
