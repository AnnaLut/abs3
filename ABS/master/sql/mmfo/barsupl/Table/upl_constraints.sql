

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_CONSTRAINTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_CONSTRAINTS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_CONSTRAINTS 
   (	FILE_ID NUMBER, 
	CONSTR_NAME VARCHAR2(250), 
	PRIORITY NUMBER, 
	FK_FILEID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_CONSTRAINTS IS '';
COMMENT ON COLUMN BARSUPL.UPL_CONSTRAINTS.FILE_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_CONSTRAINTS.CONSTR_NAME IS '';
COMMENT ON COLUMN BARSUPL.UPL_CONSTRAINTS.PRIORITY IS '';
COMMENT ON COLUMN BARSUPL.UPL_CONSTRAINTS.FK_FILEID IS '';




PROMPT *** Create  constraint PK_UPLCONSTRAINTS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CONSTRAINTS ADD CONSTRAINT PK_UPLCONSTRAINTS PRIMARY KEY (FILE_ID, CONSTR_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLCONSTRAINTS_FKPRIORITY ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CONSTRAINTS ADD CONSTRAINT FK_UPLCONSTRAINTS_FKPRIORITY FOREIGN KEY (PRIORITY)
	  REFERENCES BARSUPL.UPL_FKPRIORITY (FK_PRIORITY_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLCONSTRAINTS_FILEID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CONSTRAINTS ADD CONSTRAINT FK_UPLCONSTRAINTS_FILEID FOREIGN KEY (FILE_ID)
	  REFERENCES BARSUPL.UPL_FILES (FILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLCONSTRAINTS_FKFILEID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CONSTRAINTS ADD CONSTRAINT FK_UPLCONSTRAINTS_FKFILEID FOREIGN KEY (FK_FILEID)
	  REFERENCES BARSUPL.UPL_FILES (FILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLCONSTRAINTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLCONSTRAINTS ON BARSUPL.UPL_CONSTRAINTS (FILE_ID, CONSTR_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_CONSTRAINTS.sql =========*** En
PROMPT ===================================================================================== 
