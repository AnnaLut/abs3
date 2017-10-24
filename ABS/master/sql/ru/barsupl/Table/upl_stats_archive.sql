

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_STATS_ARCHIVE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_STATS_ARCHIVE ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_STATS_ARCHIVE 
   (	ID NUMBER, 
	UPL_BANKDATE DATE, 
	GROUP_ID NUMBER, 
	FILE_ID NUMBER, 
	FILE_CODE VARCHAR2(50), 
	SQL_ID NUMBER, 
	START_TIME DATE, 
	STOP_TIME DATE, 
	STATUS_ID NUMBER, 
	PARAMS VARCHAR2(200), 
	UPL_ERRORS VARCHAR2(500), 
	ROWS_UPLOADED NUMBER, 
	START_ARC_TIME DATE, 
	STOP_ARC_TIME DATE, 
	ARC_LOGMESS VARCHAR2(2000), 
	START_FTP_TIME DATE, 
	STOP_FTP_TIME DATE, 
	FTP_LOGMESS VARCHAR2(2000), 
	PARENT_ID NUMBER, 
	FILE_NAME VARCHAR2(200), 
	JOB_ID NUMBER, 
	REC_TYPE VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD 
  PARALLEL ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_STATS_ARCHIVE IS 'Архів статистики вивантаження даних до DWH';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.UPL_BANKDATE IS 'Банківська дата вивантаження';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.GROUP_ID IS 'Код групи вивантаження файлів (якщо запускалди из группы)';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.FILE_ID IS 'Код файла вивантаження';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.FILE_CODE IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.SQL_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.START_TIME IS 'Дата+время начала выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.STOP_TIME IS 'Дата+время окончания выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.STATUS_ID IS 'Статус выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.PARAMS IS 'Список параметров в виде param1=..., param2=....';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.UPL_ERRORS IS 'Ошибки, если выгрузка закончилдась неуспешно';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.ROWS_UPLOADED IS 'Кол-во строк при выгрузке';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.START_ARC_TIME IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.STOP_ARC_TIME IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.ARC_LOGMESS IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.START_FTP_TIME IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.STOP_FTP_TIME IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.FTP_LOGMESS IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.PARENT_ID IS 'код родителя(код выгружаемой группы)из таблицы UPL_STATS_ARCHIVE.id только для записи - файл';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.FILE_NAME IS 'Имя выгружаемого файла ( для группы -  имя архива)';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.JOB_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_ARCHIVE.REC_TYPE IS '';




PROMPT *** Create  constraint FK_UPLSTATSARCHIVE_STATUSID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS_ARCHIVE ADD CONSTRAINT FK_UPLSTATSARCHIVE_STATUSID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARSUPL.UPL_PROCESS_STATUS (STATUS_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLSTATSARCHIVE_RECORDTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS_ARCHIVE ADD CONSTRAINT FK_UPLSTATSARCHIVE_RECORDTYPE FOREIGN KEY (REC_TYPE)
	  REFERENCES BARSUPL.UPL_STATS_RECORDTYPE (REC_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLSTATSARCHIVE_PARENTID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS_ARCHIVE ADD CONSTRAINT FK_UPLSTATSARCHIVE_PARENTID FOREIGN KEY (PARENT_ID)
	  REFERENCES BARSUPL.UPL_STATS_ARCHIVE (ID) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_UPLSTATSARCHIVE ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS_ARCHIVE ADD CONSTRAINT PK_UPLSTATSARCHIVE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLSTATSARCHIVE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLSTATSARCHIVE ON BARSUPL.UPL_STATS_ARCHIVE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_UPLSTATSARCHIVE_BANKDATE ***
begin   
 execute immediate '
  CREATE INDEX BARSUPL.IDX_UPLSTATSARCHIVE_BANKDATE ON BARSUPL.UPL_STATS_ARCHIVE (UPL_BANKDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_UPLSTATSARCHIVE_GROUPID ***
begin   
 execute immediate '
  CREATE INDEX BARSUPL.IDX_UPLSTATSARCHIVE_GROUPID ON BARSUPL.UPL_STATS_ARCHIVE (GROUP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_STATS_ARCHIVE ***
grant DELETE,INSERT,SELECT                                                   on UPL_STATS_ARCHIVE to BARS;
grant DELETE,INSERT,SELECT                                                   on UPL_STATS_ARCHIVE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_STATS_ARCHIVE.sql =========*** 
PROMPT ===================================================================================== 
