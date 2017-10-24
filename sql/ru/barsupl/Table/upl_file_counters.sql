

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_FILE_COUNTERS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_FILE_COUNTERS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_FILE_COUNTERS 
   (	FILE_ID NUMBER, 
	BANK_DATE DATE, 
	CNT NUMBER, 
	 CONSTRAINT PK_UPLFILECOUNTERS PRIMARY KEY (FILE_ID, BANK_DATE, CNT) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSUPLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_FILE_COUNTERS IS 'Счетчики файлов для выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_FILE_COUNTERS.FILE_ID IS '№ файла выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_FILE_COUNTERS.BANK_DATE IS 'Банковская датат выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_FILE_COUNTERS.CNT IS 'Счетчик';




PROMPT *** Create  constraint FK_UPLFILECOUNTS_FILEID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILE_COUNTERS ADD CONSTRAINT FK_UPLFILECOUNTS_FILEID FOREIGN KEY (FILE_ID)
	  REFERENCES BARSUPL.UPL_FILES (FILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_UPLFILECOUNTERS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILE_COUNTERS ADD CONSTRAINT PK_UPLFILECOUNTERS PRIMARY KEY (FILE_ID, BANK_DATE, CNT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLFILECOUNTERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLFILECOUNTERS ON BARSUPL.UPL_FILE_COUNTERS (FILE_ID, BANK_DATE, CNT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_FILE_COUNTERS.sql =========*** 
PROMPT ===================================================================================== 
