

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_COLUMNS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_COLUMNS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_COLUMNS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_COLUMNS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_COLUMNS ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_COLUMNS 
   (	TABID NUMBER(38,0), 
	COLID NUMBER(38,0), 
	COLNAME VARCHAR2(30), 
	COLTYPE CHAR(1), 
	SEMANTIC VARCHAR2(80), 
	SHOWWIDTH NUMBER(3,1), 
	SHOWMAXCHAR NUMBER(5,0), 
	SHOWPOS NUMBER(3,0), 
	SHOWIN_RO NUMBER(1,0) DEFAULT 0, 
	SHOWRETVAL NUMBER(1,0) DEFAULT 0, 
	INSTNSSEMANTIC NUMBER(1,0) DEFAULT 0, 
	EXTRNVAL NUMBER(1,0) DEFAULT 0, 
	SHOWREL_CTYPE CHAR(1), 
	SHOWFORMAT VARCHAR2(30), 
	SHOWIN_FLTR NUMBER(1,0) DEFAULT 0, 
	SHOWREF NUMBER(1,0) DEFAULT 0, 
	SHOWRESULT VARCHAR2(254), 
	CASE_SENSITIVE NUMBER(1,0), 
	NOT_TO_EDIT NUMBER(1,0) DEFAULT 0, 
	NOT_TO_SHOW NUMBER(1,0) DEFAULT 0, 
	SIMPLE_FILTER NUMBER(1,0) DEFAULT 0, 
	FORM_NAME VARCHAR2(254), 
	OPER_ID NUMBER, 
	WEB_FORM_NAME VARCHAR2(254), 
	BRANCH VARCHAR2(30) DEFAULT SYS_CONTEXT(''bars_context'',''user_branch''), 
	INPUT_IN_NEW_RECORD NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_COLUMNS ***
 exec bpa.alter_policies('META_COLUMNS');


COMMENT ON TABLE BARS.META_COLUMNS IS 'Метаописание. Описание полей таблиц системы';
COMMENT ON COLUMN BARS.META_COLUMNS.WEB_FORM_NAME IS 'Вызов формы (функции веб) по DoubleClick на колонке';
COMMENT ON COLUMN BARS.META_COLUMNS.BRANCH IS '';
COMMENT ON COLUMN BARS.META_COLUMNS.INPUT_IN_NEW_RECORD IS 'Заполнять в форме добавления новой записи';
COMMENT ON COLUMN BARS.META_COLUMNS.TABID IS 'Идентификатор таблицы';
COMMENT ON COLUMN BARS.META_COLUMNS.COLID IS 'Идентификатор столбца';
COMMENT ON COLUMN BARS.META_COLUMNS.COLNAME IS 'Наименование столбца';
COMMENT ON COLUMN BARS.META_COLUMNS.COLTYPE IS 'Тип столбца';
COMMENT ON COLUMN BARS.META_COLUMNS.SEMANTIC IS 'Семантика';
COMMENT ON COLUMN BARS.META_COLUMNS.SHOWWIDTH IS 'Визуальная ширина';
COMMENT ON COLUMN BARS.META_COLUMNS.SHOWMAXCHAR IS 'Максимальное кол-во символов';
COMMENT ON COLUMN BARS.META_COLUMNS.SHOWPOS IS 'Позиция';
COMMENT ON COLUMN BARS.META_COLUMNS.SHOWIN_RO IS 'Признак использования поля в режиме Выбор';
COMMENT ON COLUMN BARS.META_COLUMNS.SHOWRETVAL IS 'Признак первичного ключа';
COMMENT ON COLUMN BARS.META_COLUMNS.INSTNSSEMANTIC IS 'Признак семантики';
COMMENT ON COLUMN BARS.META_COLUMNS.EXTRNVAL IS 'Признак чужого ключа';
COMMENT ON COLUMN BARS.META_COLUMNS.SHOWREL_CTYPE IS 'Код типа отношения';
COMMENT ON COLUMN BARS.META_COLUMNS.SHOWFORMAT IS 'Формат ввода колонки';
COMMENT ON COLUMN BARS.META_COLUMNS.SHOWIN_FLTR IS 'Признак использования поля в фильтрах и поисках';
COMMENT ON COLUMN BARS.META_COLUMNS.SHOWREF IS 'Флаг: показывать для колонки справочник';
COMMENT ON COLUMN BARS.META_COLUMNS.SHOWRESULT IS 'Формула для итоговой строки';
COMMENT ON COLUMN BARS.META_COLUMNS.CASE_SENSITIVE IS '';
COMMENT ON COLUMN BARS.META_COLUMNS.NOT_TO_EDIT IS 'Не показывать колонку в справочнике';
COMMENT ON COLUMN BARS.META_COLUMNS.FORM_NAME IS 'Вызов формы (функции центуры) по DoubleClick';
COMMENT ON COLUMN BARS.META_COLUMNS.NOT_TO_SHOW IS '';
COMMENT ON COLUMN BARS.META_COLUMNS.SIMPLE_FILTER IS 'Признак простого фильтра';
COMMENT ON COLUMN BARS.META_COLUMNS.OPER_ID IS 'Код функции для вызова по double click - web';




PROMPT *** Create  constraint FK_METACOLS_OPERLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT FK_METACOLS_OPERLIST FOREIGN KEY (OPER_ID)
	  REFERENCES BARS.OPERLIST (CODEOPER) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METACOLUMNS_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT FK_METACOLUMNS_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METACOLUMNS_METARELTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT FK_METACOLUMNS_METARELTYPES FOREIGN KEY (SHOWREL_CTYPE)
	  REFERENCES BARS.META_RELTYPES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METACOLUMNS_METACOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT FK_METACOLUMNS_METACOLTYPES FOREIGN KEY (COLTYPE)
	  REFERENCES BARS.META_COLTYPES (COLTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_SHOWINRO ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT CC_METACOLUMNS_SHOWINRO CHECK (showin_ro in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_SHOWINFLTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT CC_METACOLUMNS_SHOWINFLTR CHECK (showin_fltr in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_INSTNSSEMANTIC ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT CC_METACOLUMNS_INSTNSSEMANTIC CHECK (instnssemantic in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_EXTRNVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT CC_METACOLUMNS_EXTRNVAL CHECK (extrnval in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_METACOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT UK_METACOLUMNS UNIQUE (TABID, COLNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METACOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT PK_METACOLUMNS PRIMARY KEY (TABID, COLID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_COLTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (COLTYPE CONSTRAINT CC_METACOLUMNS_COLTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_COLNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (COLNAME CONSTRAINT CC_METACOLUMNS_COLNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_COLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (COLID CONSTRAINT CC_METACOLUMNS_COLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (TABID CONSTRAINT CC_METACOLUMNS_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_SIMPLEFILTER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (SIMPLE_FILTER CONSTRAINT CC_METACOLUMNS_SIMPLEFILTER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_NOTTOSHOW_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (NOT_TO_SHOW CONSTRAINT CC_METACOLUMNS_NOTTOSHOW_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_NOTTOEDIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (NOT_TO_EDIT CONSTRAINT CC_METACOLUMNS_NOTTOEDIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_CASESENSITIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT CC_METACOLUMNS_CASESENSITIVE CHECK (case_sensitive in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_SHOWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (SHOWREF CONSTRAINT CC_METACOLUMNS_SHOWREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_SHOWINFLTR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (SHOWIN_FLTR CONSTRAINT CC_METACOLUMNS_SHOWINFLTR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_EXTRNVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (EXTRNVAL CONSTRAINT CC_METACOLUMNS_EXTRNVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_INSTNSSMNTIC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (INSTNSSEMANTIC CONSTRAINT CC_METACOLUMNS_INSTNSSMNTIC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_SHOWRETVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (SHOWRETVAL CONSTRAINT CC_METACOLUMNS_SHOWRETVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_SHOWINRO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (SHOWIN_RO CONSTRAINT CC_METACOLUMNS_SHOWINRO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_INNEWREC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS MODIFY (INPUT_IN_NEW_RECORD CONSTRAINT CC_METACOLUMNS_INNEWREC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_SHOWRETVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT CC_METACOLUMNS_SHOWRETVAL CHECK (showretval in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLUMNS_SHOWREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT CC_METACOLUMNS_SHOWREF CHECK (showref in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METACOLUMNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METACOLUMNS ON BARS.META_COLUMNS (TABID, COLID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_METACOLUMNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_METACOLUMNS ON BARS.META_COLUMNS (TABID, COLNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_COLUMNS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_COLUMNS    to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_COLUMNS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_COLUMNS    to CUST001;
grant SELECT                                                                 on META_COLUMNS    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_COLUMNS    to WR_ALL_RIGHTS;
grant SELECT                                                                 on META_COLUMNS    to WR_CBIREP;
grant SELECT                                                                 on META_COLUMNS    to WR_CREDIT;
grant SELECT                                                                 on META_COLUMNS    to WR_CUSTLIST;
grant SELECT                                                                 on META_COLUMNS    to WR_CUSTREG;
grant SELECT                                                                 on META_COLUMNS    to WR_DOC_INPUT;
grant SELECT                                                                 on META_COLUMNS    to WR_FILTER;
grant SELECT                                                                 on META_COLUMNS    to WR_METATAB;
grant SELECT                                                                 on META_COLUMNS    to WR_ND_ACCOUNTS;
grant SELECT                                                                 on META_COLUMNS    to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_COLUMNS.sql =========*** End *** 
PROMPT ===================================================================================== 
