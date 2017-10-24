

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_COLUMNS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_COLUMNS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_COLUMNS 
   (	FILE_ID NUMBER, 
	COL_ID NUMBER, 
	COL_NAME VARCHAR2(100), 
	COL_DESC VARCHAR2(500), 
	COL_TYPE VARCHAR2(10), 
	COL_LENGTH NUMBER, 
	COL_SCALE NUMBER, 
	COL_FORMAT VARCHAR2(50), 
	PK_CONSTR CHAR(1), 
	NULLABLE CHAR(1) DEFAULT ''Y'', 
	NULL_VALUES VARCHAR2(50), 
	REPL_CHARS_WITH VARCHAR2(50), 
	SKELETON_VALUES VARCHAR2(50), 
	PK_CONSTR_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_COLUMNS IS 'Информация о колонках выгрузки в файл';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.SKELETON_VALUES IS '';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.PK_CONSTR_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.FILE_ID IS 'Код запроса выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.COL_ID IS 'Код полонки по-порядку';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.COL_NAME IS 'Наименование колонки';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.COL_DESC IS 'Описание колонки';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.COL_TYPE IS 'Тип колонки из справочника UPL_TYPES';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.COL_LENGTH IS 'Длина колонки - визуальная(эта длиння включает в себя знаки разделения разрядов и дробной части)';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.COL_SCALE IS 'Кол-во знаков после запятой для дробных чисел';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.COL_FORMAT IS 'Формат колоки, наприм. 99.99000.00';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.PK_CONSTR IS 'Является ли поле частью первичного ключа для данных Y/null';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.NULLABLE IS 'Y/N';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.NULL_VALUES IS 'Зеачения для null колонок';
COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.REPL_CHARS_WITH IS 'Замещение символов, указанных через знак | последовательностью символов, которая указана через запятую';




PROMPT *** Create  constraint FK_UPLCOLUMNS_COLTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS ADD CONSTRAINT FK_UPLCOLUMNS_COLTYPE FOREIGN KEY (COL_TYPE)
	  REFERENCES BARSUPL.UPL_COL_TYPES (TYPE_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_UPLCOLUMNS_FILEID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS ADD CONSTRAINT FK_UPLCOLUMNS_FILEID FOREIGN KEY (FILE_ID)
	  REFERENCES BARSUPL.UPL_FILES (FILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLCOLUMNS_PKCONSTRID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS ADD CONSTRAINT CC_UPLCOLUMNS_PKCONSTRID CHECK ((pk_constr = ''Y'' AND pk_constr_id is Not Null) or (pk_constr is Null AND pk_constr_id is Null)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLCOLUMNS_NULLABLE ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS ADD CONSTRAINT CC_UPLCOLUMNS_NULLABLE CHECK ( NULLABLE = ''Y'' OR NULLABLE = ''N'' ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLCOLUMNS_NULLABLE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS MODIFY (NULLABLE CONSTRAINT CC_UPLCOLUMNS_NULLABLE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLCOLUMNS_COLFORMAT ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS ADD CONSTRAINT CC_UPLCOLUMNS_COLFORMAT CHECK ( (COL_TYPE  = ''NUMBER'' AND COL_SCALE > 0 AND COL_FORMAT is Not Null) or
        (COL_TYPE != ''NUMBER'' AND COL_SCALE > 0 AND COL_FORMAT is Null)     or
        (COL_TYPE  = ''DATE''   AND COL_FORMAT is Not Null)                   or
        (COL_TYPE != ''DATE''   AND COL_FORMAT is Null) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLCOLUMNS_COLSCALE ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS ADD CONSTRAINT CC_UPLCOLUMNS_COLSCALE CHECK ((COL_TYPE = ''NUMBER'' AND COL_SCALE is Not Null) or (COL_TYPE != ''NUMBER'' AND COL_SCALE is Null)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLCOLUMNS_COLNAME ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS ADD CONSTRAINT CC_UPLCOLUMNS_COLNAME CHECK ( regexp_like(COL_NAME,''^[a-zA-Z][a-zA-Z0-9_]*$'') ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLCOLUMNS_FKCONSTR ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS ADD CONSTRAINT CC_UPLCOLUMNS_FKCONSTR CHECK (pk_constr in (''Y'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLCOLUMNS_PKCONSTR ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS ADD CONSTRAINT CC_UPLCOLUMNS_PKCONSTR CHECK (pk_constr in (''Y'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_UPLCOLUMNS_FILEID_COLNAME ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS ADD CONSTRAINT UK_UPLCOLUMNS_FILEID_COLNAME UNIQUE (FILE_ID, COL_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_UPLCOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS ADD CONSTRAINT PK_UPLCOLUMNS PRIMARY KEY (FILE_ID, COL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLCOLS_LEN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS MODIFY (COL_LENGTH CONSTRAINT CC_UPLCOLS_LEN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLCOLS_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COLUMNS MODIFY (COL_TYPE CONSTRAINT CC_UPLCOLS_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLCOLUMNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLCOLUMNS ON BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_UPLCOLUMNS_FILEID_COLNAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.UK_UPLCOLUMNS_FILEID_COLNAME ON BARSUPL.UPL_COLUMNS (FILE_ID, COL_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Add columns PREFUN ***
BEGIN
    begin
        EXECUTE IMMEDIATE 'ALTER TABLE BARSUPL.UPL_COLUMNS ADD (PREFUN VARCHAR(300))';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN BARSUPL.UPL_COLUMNS.PREFUN IS ''Функция дополнительной обработки данных''';
    EXCEPTION WHEN OTHERS
       THEN
          IF SQLCODE = -01430
              THEN dbms_output.put_line('column PREFUN already exists in table UPL_COLUMNS');
          ELSE RAISE;
          END IF;
    end;
END;
/






PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_COLUMNS.sql =========*** End **
PROMPT ===================================================================================== 
