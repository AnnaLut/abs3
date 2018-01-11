

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DBF_SYNC_TABS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DBF_SYNC_TABS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DBF_SYNC_TABS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DBF_SYNC_TABS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DBF_SYNC_TABS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DBF_SYNC_TABS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DBF_SYNC_TABS 
   (	TABID NUMBER(38,0), 
	S_SELECT VARCHAR2(4000), 
	S_INSERT VARCHAR2(4000), 
	S_UPDATE VARCHAR2(4000), 
	S_DELETE VARCHAR2(4000), 
	FILE_DATE DATE, 
	SYNC_FLAG NUMBER(1,0), 
	ENCODE VARCHAR2(3), 
	FILE_NAME VARCHAR2(100), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	SYNC_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DBF_SYNC_TABS ***
 exec bpa.alter_policies('DBF_SYNC_TABS');


COMMENT ON TABLE BARS.DBF_SYNC_TABS IS 'ТАБЛИЦЫ, СИНХРОНИЗИРУЕМЫЕ ИЗ DBF ФАЙЛОВ';
COMMENT ON COLUMN BARS.DBF_SYNC_TABS.SYNC_DATE IS 'Дата синхронізації довідника';
COMMENT ON COLUMN BARS.DBF_SYNC_TABS.TABID IS 'Ид. таблицы';
COMMENT ON COLUMN BARS.DBF_SYNC_TABS.S_SELECT IS 'Выражение на выборку изменений (сравнение БД с файлом)';
COMMENT ON COLUMN BARS.DBF_SYNC_TABS.S_INSERT IS 'Выражение на вставку недостающих записей';
COMMENT ON COLUMN BARS.DBF_SYNC_TABS.S_UPDATE IS 'Выражение на обновление изменившихся записей';
COMMENT ON COLUMN BARS.DBF_SYNC_TABS.S_DELETE IS 'Выражение на удаление лишних записей';
COMMENT ON COLUMN BARS.DBF_SYNC_TABS.FILE_DATE IS 'Дата файла';
COMMENT ON COLUMN BARS.DBF_SYNC_TABS.SYNC_FLAG IS '';
COMMENT ON COLUMN BARS.DBF_SYNC_TABS.ENCODE IS 'Кодировка исходного DBF: DOS(cp866),WIN(win),UKG(укр.гост))';
COMMENT ON COLUMN BARS.DBF_SYNC_TABS.FILE_NAME IS 'Имя DBF файла';
COMMENT ON COLUMN BARS.DBF_SYNC_TABS.BRANCH IS '';




PROMPT *** Create  constraint CC_DBFSYNCTABS_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DBF_SYNC_TABS MODIFY (TABID CONSTRAINT CC_DBFSYNCTABS_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DBFSYNCTABS_SYNCFLAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.DBF_SYNC_TABS ADD CONSTRAINT CC_DBFSYNCTABS_SYNCFLAG CHECK (sync_flag in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DBFSYNC_ENCODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DBF_SYNC_TABS ADD CONSTRAINT CC_DBFSYNC_ENCODE CHECK (encode in (''DOS'',''WIN'',''UKG'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DBFSYNCTABS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DBF_SYNC_TABS ADD CONSTRAINT PK_DBFSYNCTABS PRIMARY KEY (TABID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DBFSYNCTABS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DBFSYNCTABS ON BARS.DBF_SYNC_TABS (TABID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DBF_SYNC_TABS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DBF_SYNC_TABS   to ABS_ADMIN;
grant SELECT                                                                 on DBF_SYNC_TABS   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DBF_SYNC_TABS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DBF_SYNC_TABS   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DBF_SYNC_TABS   to DBF_SYNC_TABS;
grant SELECT                                                                 on DBF_SYNC_TABS   to START1;
grant SELECT                                                                 on DBF_SYNC_TABS   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DBF_SYNC_TABS   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DBF_SYNC_TABS   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DBF_SYNC_TABS.sql =========*** End ***
PROMPT ===================================================================================== 
