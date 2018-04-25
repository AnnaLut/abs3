

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_SOURCES_FIELDS.sql =========*** Run *
PROMPT ===================================================================================== 

PROMPT *** Create  table UPL_SOURCES_FIELDS ***
begin 
  execute immediate '
CREATE TABLE BARSUPL.UPL_SOURCES_FIELDS
( OWNER           VARCHAR2(30 BYTE)    CONSTRAINT UPL_SSF_OWNER_NN       NOT NULL,
  TABLE_NAME      VARCHAR2(30 BYTE)    CONSTRAINT UPL_SSF_TABLE_NAME_NN  NOT NULL,
  COLUMN_NAME     VARCHAR2(30 BYTE)    CONSTRAINT UPL_SSF_COLUMN_NAME_NN NOT NULL,
  COLUMN_ID       NUMBER               CONSTRAINT UPL_SSF_COLUMN_ID_NN   NOT NULL,
  DATA_TYPE       VARCHAR2(106 BYTE),
  DATA_LENGTH     NUMBER,
  DATA_PRECISION  NUMBER,
  NULLABLE        VARCHAR2(1 BYTE),
  UPL_BANKDATE    DATE                 CONSTRAINT UPL_SSF_BANKDATE_NN    NOT NULL,
  DATE_VER        DATE default sysdate CONSTRAINT UPL_SSF_DATE_VER_NN    NOT NULL
) TABLESPACE BRSUPLD';

exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end;
/

COMMENT ON TABLE  BARSUPL.UPL_SOURCES_FIELDS                IS 'Перечеь полей для контроля изменений структуры';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES_FIELDS.OWNER          IS 'Схема объекта';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES_FIELDS.TABLE_NAME     IS 'Имя таблицы/view';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES_FIELDS.COLUMN_NAME    IS 'Наименование колонки';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES_FIELDS.COLUMN_ID      IS 'ID колонки';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES_FIELDS.DATA_TYPE      IS 'Тип данных';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES_FIELDS.DATA_LENGTH    IS 'Длинна поля';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES_FIELDS.DATA_PRECISION IS 'Длинна дробной части';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES_FIELDS.NULLABLE       IS 'Может быть NULL';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES_FIELDS.UPL_BANKDATE   IS 'Банковская дата выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES_FIELDS.DATE_VER       IS 'Дата+время изменения';

PROMPT *** Create  index  PK_UPL_SOURCES_FIELDS***
begin   
 execute immediate 'CREATE UNIQUE INDEX BARSUPL.PK_UPL_SOURCES_FIELDS ON BARSUPL.UPL_SOURCES_FIELDS (
					OWNER, TABLE_NAME, COLUMN_NAME, UPL_BANKDATE) TABLESPACE BRSUPLD';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
end;
/

PROMPT *** Create  constraint PK_UPL_SOURCES_FIELDS ***
begin   
 execute immediate '
ALTER TABLE BARSUPL.UPL_SOURCES_FIELDS ADD (
  CONSTRAINT PK_UPL_SOURCES_FIELDS PRIMARY KEY (OWNER, TABLE_NAME, COLUMN_NAME, UPL_BANKDATE) USING INDEX BARSUPL.PK_UPL_SOURCES_FIELDS ENABLE VALIDATE,
  CONSTRAINT FK_UPL_SSO FOREIGN KEY (OWNER, TABLE_NAME) REFERENCES BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME) DEFERRABLE INITIALLY DEFERRED ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

PROMPT *** Create  grants   ***
grant SELECT                                                                 on UPL_SOURCES_FIELDS to BARSUPL;
grant SELECT                                                                 on UPL_SOURCES_FIELDS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on UPL_SOURCES_FIELDS to START1;
grant SELECT                                                                 on UPL_SOURCES_FIELDS to BARS_DM;
grant SELECT                                                                 on UPL_SOURCES_FIELDS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_SOURCES_FIELDS.sql =========*** End *
PROMPT ===================================================================================== 


