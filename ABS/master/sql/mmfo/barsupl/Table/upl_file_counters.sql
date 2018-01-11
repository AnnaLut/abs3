

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
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_FILE_COUNTERS IS 'Счетчики файлов для выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_FILE_COUNTERS.FILE_ID IS '№ файла выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_FILE_COUNTERS.BANK_DATE IS 'Банковская датат выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_FILE_COUNTERS.CNT IS 'Счетчик';
COMMENT ON COLUMN BARSUPL.UPL_FILE_COUNTERS.KF IS '';




PROMPT *** Create  constraint SYS_C0061186 ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILE_COUNTERS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_UPLFILECOUNTERS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILE_COUNTERS ADD CONSTRAINT PK_UPLFILECOUNTERS PRIMARY KEY (KF, FILE_ID, BANK_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLFILECOUNTERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLFILECOUNTERS ON BARSUPL.UPL_FILE_COUNTERS (KF, FILE_ID, BANK_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_FILE_COUNTERS ***
grant SELECT                                                                 on UPL_FILE_COUNTERS to BARSREADER_ROLE;
grant SELECT                                                                 on UPL_FILE_COUNTERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_FILE_COUNTERS.sql =========*** 
PROMPT ===================================================================================== 
