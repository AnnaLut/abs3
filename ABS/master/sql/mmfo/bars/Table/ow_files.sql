

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_FILES.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_FILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_FILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_FILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_FILES 
   (	ID NUMBER(22,0), 
	FILE_TYPE VARCHAR2(30), 
	FILE_NAME VARCHAR2(100), 
	FILE_DATE DATE DEFAULT sysdate, 
	FILE_N NUMBER(22,0), 
	FILE_STATUS NUMBER(2,0), 
	FILE_BODY BLOB, 
	ORIGIN NUMBER(1,0), 
	ERR_TEXT VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (FILE_BODY) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_FILES ***
 exec bpa.alter_policies('OW_FILES');


COMMENT ON TABLE BARS.OW_FILES IS 'W4. Импортированные файлы';
COMMENT ON COLUMN BARS.OW_FILES.KF IS '';
COMMENT ON COLUMN BARS.OW_FILES.ID IS 'Ід.';
COMMENT ON COLUMN BARS.OW_FILES.FILE_TYPE IS 'Тип файла';
COMMENT ON COLUMN BARS.OW_FILES.FILE_NAME IS 'Ім'я файлу';
COMMENT ON COLUMN BARS.OW_FILES.FILE_DATE IS 'Дата імпорту іайлу';
COMMENT ON COLUMN BARS.OW_FILES.FILE_N IS 'Кількість документів';
COMMENT ON COLUMN BARS.OW_FILES.FILE_STATUS IS 'Статус файла: 0-тело файла (clob) помещено в БД, 1-строки файла помещены в таблицу, 2-строки файла обработаны, 3-ошибка разбора тела файла';
COMMENT ON COLUMN BARS.OW_FILES.FILE_BODY IS '';
COMMENT ON COLUMN BARS.OW_FILES.ORIGIN IS 'Источник: 0-АБС, 1-вертушка';
COMMENT ON COLUMN BARS.OW_FILES.ERR_TEXT IS '';




PROMPT *** Create  constraint CC_OWFILES_FILESTATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES ADD CONSTRAINT CC_OWFILES_FILESTATUS CHECK (file_status between 0 and 99) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES MODIFY (KF CONSTRAINT CC_OWFILES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES ADD CONSTRAINT PK_OWFILES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWFILES_FILESTATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES ADD CONSTRAINT CC_OWFILES_FILESTATUS_NN CHECK (file_status is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWFILES_ORIGIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES ADD CONSTRAINT CC_OWFILES_ORIGIN_NN CHECK (origin is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWFILES_ORIGIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES ADD CONSTRAINT CC_OWFILES_ORIGIN CHECK (origin in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWFILES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES MODIFY (ID CONSTRAINT CC_OWFILES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWFILES_FILETYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES MODIFY (FILE_TYPE CONSTRAINT CC_OWFILES_FILETYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWFILES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES MODIFY (FILE_NAME CONSTRAINT CC_OWFILES_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWFILES_FILEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILES MODIFY (FILE_DATE CONSTRAINT CC_OWFILES_FILEDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWOICFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWOICFILES ON BARS.OW_FILES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OW_FILES_DATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OW_FILES_DATE ON BARS.OW_FILES (TRUNC(FILE_DATE)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_FILES ***
grant SELECT                                                                 on OW_FILES        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_FILES        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_FILES        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_FILES        to OW;
grant SELECT                                                                 on OW_FILES        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_FILES.sql =========*** End *** ====
PROMPT ===================================================================================== 
