

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/UPDATE_TBL_STAT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to UPDATE_TBL_STAT ***

BEGIN 
        execute immediate  
          'begin  
               bars.bpa.alter_policy_info(''UPDATE_TBL_STAT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bars.bpa.alter_policy_info(''UPDATE_TBL_STAT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
           end; 
          '; 
END; 
/

PROMPT *** Create  table UPDATE_TBL_STAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.UPDATE_TBL_STAT
( ID          NUMBER                            NOT NULL,
  STAT_ID     NUMBER,
  FIELD_NAME  VARCHAR2(50 BYTE)                 NOT NULL,
  FIELD_TYPE  VARCHAR2(100 BYTE),
  VALUE       VARCHAR2(500 BYTE),
  RUN_ID      NUMBER                            NOT NULL,
  STARTDATE   DATE                              NOT NULL,
  ENDDATE     DATE,
  TBL_NAME    VARCHAR2(100 BYTE)                NOT NULL,
  KF          VARCHAR2(6 BYTE)                  DEFAULT sys_context(''bars_context'',''user_mfo'') NOT NULL,
  LOG_MESS    VARCHAR2(3000 BYTE)
)
TABLESPACE BRSSMLD';

exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end;
/


exec bars.bpa.alter_policies('UPDATE_TBL_STAT');


COMMENT ON TABLE BARS.UPDATE_TBL_STAT IS 'Протокол выполнения проверки расхождений или синхронизации данных в Update-таблицах';
COMMENT ON COLUMN BARS.UPDATE_TBL_STAT.ID IS 'Уникальный номер записи';
COMMENT ON COLUMN BARS.UPDATE_TBL_STAT.STAT_ID IS 'Идентификатор Barsupl.UPL_STATS, заполняется если выполнялась выгрузка файлов';
COMMENT ON COLUMN BARS.UPDATE_TBL_STAT.FIELD_NAME IS 'Поле в Update-таблице или Идентификатор';
COMMENT ON COLUMN BARS.UPDATE_TBL_STAT.FIELD_TYPE IS 'Тип значения';
COMMENT ON COLUMN BARS.UPDATE_TBL_STAT.VALUE IS 'Значение';
COMMENT ON COLUMN BARS.UPDATE_TBL_STAT.RUN_ID IS 'Уникальный номер запуска';
COMMENT ON COLUMN BARS.UPDATE_TBL_STAT.STARTDATE IS 'Начало выполнения проверки расхождений или синхронизации';
COMMENT ON COLUMN BARS.UPDATE_TBL_STAT.ENDDATE IS 'Конец выполнения проверки расхождений или синхронизации';
COMMENT ON COLUMN BARS.UPDATE_TBL_STAT.TBL_NAME IS 'Таблица, по которой выполняется проверка или синхронизация';
COMMENT ON COLUMN BARS.UPDATE_TBL_STAT.KF IS 'KF';


PROMPT *** Create  index  PK_UPDATE_TBL_STAT***
begin   
 execute immediate '
CREATE UNIQUE INDEX BARS.PK_UPDATE_TBL_STAT ON BARS.UPDATE_TBL_STAT (ID)
TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_UPDATE_TBL_STAT ***
begin   
 execute immediate '
 ALTER TABLE BARS.UPDATE_TBL_STAT ADD (
  CONSTRAINT PK_UPDATE_TBL_STAT  PRIMARY KEY(ID) USING INDEX BARS.PK_UPDATE_TBL_STAT
  ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index  IDX_UPDTBLSTAT_KF***
begin   
 execute immediate ' CREATE INDEX BARS.IDX_UPDTBLSTAT_KF ON BARS.UPDATE_TBL_STAT (KF) TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index  IDX_UPDTBLSTAT_STATID***
begin   
 execute immediate ' CREATE INDEX BARS.IDX_UPDTBLSTAT_STATID ON BARS.UPDATE_TBL_STAT (STAT_ID) TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index  IDX_UPDTBLSTAT_RUNID***
begin   
 execute immediate ' CREATE INDEX BARS.IDX_UPDTBLSTAT_RUNID ON BARS.UPDATE_TBL_STAT (RUN_ID) TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index  IDX_UPDTBLSTAT_TBL_NAME***
begin   
 execute immediate ' CREATE INDEX BARS.IDX_UPDTBLSTAT_TBL_NAME ON BARS.UPDATE_TBL_STAT (TBL_NAME) TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants   ***
grant SELECT                                                                 on UPDATE_TBL_STAT to BARSUPL;
grant SELECT                                                                 on UPDATE_TBL_STAT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on UPDATE_TBL_STAT to START1;
grant SELECT                                                                 on UPDATE_TBL_STAT to BARS_DM;
grant SELECT                                                                 on UPDATE_TBL_STAT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/UPDATE_TBL_STAT.sql =========*** End *
PROMPT ===================================================================================== 
