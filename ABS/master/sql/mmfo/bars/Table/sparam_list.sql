PROMPT BARS/Table/SPARAM_LIST.sql

PROMPT *** ALTER_POLICY_INFO to SPARAM_LIST ***

begin
  bpa.alter_policy_info( 'SPARAM_LIST', 'CENTER', null, null, null, null );
  bpa.alter_policy_info( 'SPARAM_LIST', 'FILIAL', null,  'E',  'E',  'E' );
  bpa.alter_policy_info( 'SPARAM_LIST', 'WHOLE' , null, null, null, null );
end;
/

PROMPT *** Create  table SPARAM_LIST ***
begin 
  execute immediate 'create table SPARAM_LIST 
( SPID            NUMBER(38), 
  NAME            VARCHAR2(30), 
  SEMANTIC        VARCHAR2(60), 
  TABNAME         VARCHAR2(30), 
  TYPE            CHAR(1), 
  NSINAME         VARCHAR2(60), 
  INUSE           NUMBER(1), 
  PKNAME          VARCHAR2(60), 
  DELONNULL       NUMBER(1,0), 
  NSISQLWHERE     VARCHAR2(250), 
  SQLCONDITION    VARCHAR2(250), 
  TAG             VARCHAR2(8), 
  TABCOLUMN_CHECK VARCHAR2(30), 
  CODE            VARCHAR2(30) default ''OTHERS'', 
  HIST            NUMBER(1), 
  MAX_CHAR        NUMBER(10), 
  BRANCH          varchar2(30) default sys_context(''BARS_CONTEXT'',''USER_BRANCH''),
  DEF_FLAG        varchar2(1)  default ''N'',
  EDITABLE        number(1)    default 1
) tablespace BRSSMLD';
exception
  when others then
    if sqlcode=-955 then null; else raise; end if; 
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

prompt *** add column DEF_FLAG ***

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table SPARAM_LIST add DEF_FLAG varchar2(1) default 'N']';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

prompt *** add column EDITABLE ***

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table SPARAM_LIST add EDITABLE number(1) default 1]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

PROMPT *** ALTER_POLICIES to SPARAM_LIST ***
exec bpa.alter_policies('SPARAM_LIST');

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  SPARAM_LIST IS 'Таблица описания спецпараметров счета в системе';

COMMENT ON COLUMN SPARAM_LIST.SPID IS 'Идентификатор Параметра';
COMMENT ON COLUMN SPARAM_LIST.NAME IS 'Наименование';
COMMENT ON COLUMN SPARAM_LIST.SEMANTIC IS 'Описание';
COMMENT ON COLUMN SPARAM_LIST.TABNAME IS 'Имя таблицы хранилища параметра';
COMMENT ON COLUMN SPARAM_LIST.TYPE IS 'Тип параметра';
COMMENT ON COLUMN SPARAM_LIST.NSINAME IS 'Имя таблицы справочника';
COMMENT ON COLUMN SPARAM_LIST.INUSE IS 'В использовании';
COMMENT ON COLUMN SPARAM_LIST.PKNAME IS 'Ключ';
COMMENT ON COLUMN SPARAM_LIST.DELONNULL IS 'Флаг: удалять строку из справочника если значение спецпар-ра is null';
COMMENT ON COLUMN SPARAM_LIST.NSISQLWHERE IS 'Условие фильтра для справочника';
COMMENT ON COLUMN SPARAM_LIST.SQLCONDITION IS 'Условие для отбора параметра';
COMMENT ON COLUMN SPARAM_LIST.TAG IS 'Наименование поля';
COMMENT ON COLUMN SPARAM_LIST.TABCOLUMN_CHECK IS 'Контроль значения по полю';
COMMENT ON COLUMN SPARAM_LIST.CODE IS '';
COMMENT ON COLUMN SPARAM_LIST.HIST IS 'Признак: используется в историзированной таблице параметров';
COMMENT ON COLUMN SPARAM_LIST.MAX_CHAR IS 'Max кол-во символов';
COMMENT ON COLUMN SPARAM_LIST.BRANCH IS 'Hierarchical Branch Code';
COMMENT ON COLUMN SPARAM_LIST.DEF_FLAG IS 'Признак установки значения по-умолчанию (acc_reg.set_default_sparams)';
comment on column SPARAM_LIST.EDITABLE is 'Сan be edited by the user (1-Yes/0-No)';


PROMPT *** Create  constraint CC_SPARAMLIST_TYPE ***

begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT CC_SPARAMLIST_TYPE CHECK (type in (''S'',''N'',''D'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create constraint CC_SPARAMLIST_DELONNULL ***

begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT CC_SPARAMLIST_DELONNULL CHECK (delonnull in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create constraint CC_SPARAMLIST_INUSE ***

begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT CC_SPARAMLIST_INUSE CHECK (inuse in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create constraint CC_SPARAMLIST_EDITABLE ***

declare
  E_CHK_CNSTRN_EXISTS exception;
  pragma exception_init( E_CHK_CNSTRN_EXISTS, -02264 );
begin
  execute immediate q'[alter table SPARAM_LIST add constraint CC_SPARAMLIST_EDITABLE check ( EDITABLE in (0,1) )]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CHK_CNSTRN_EXISTS
  then null;
end;
/


PROMPT *** Create  constraint PK_SPARAMLIST ***

begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT PK_SPARAMLIST PRIMARY KEY (SPID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (BRANCH CONSTRAINT CC_SPARAMLIST_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (CODE CONSTRAINT CC_SPARAMLIST_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_INUSE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (INUSE CONSTRAINT CC_SPARAMLIST_INUSE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (TYPE CONSTRAINT CC_SPARAMLIST_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_TABNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (TABNAME CONSTRAINT CC_SPARAMLIST_TABNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_SEMANTIC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (SEMANTIC CONSTRAINT CC_SPARAMLIST_SEMANTIC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (NAME CONSTRAINT CC_SPARAMLIST_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMLIST_SPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST MODIFY (SPID CONSTRAINT CC_SPARAMLIST_SPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPARAMLIST_CODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT FK_SPARAMLIST_CODES FOREIGN KEY (CODE)
	  REFERENCES BARS.SPARAM_CODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPARAMLIST_METACOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT FK_SPARAMLIST_METACOLTYPES FOREIGN KEY (TYPE)
	  REFERENCES BARS.META_COLTYPES (COLTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPARAMLIST_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_LIST ADD CONSTRAINT FK_SPARAMLIST_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  index PK_SPARAMLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPARAMLIST ON BARS.SPARAM_LIST (SPID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

prompt Create index I_SPARAM_LIST_NAME (on upper(SPARAM_LIST.NAME))
begin
    execute immediate '
    create index I_SPARAM_LIST_NAME on bars.sparam_list(upper(name)) tablespace brssmli compute statistics';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/



PROMPT *** Create  grants  SPARAM_LIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPARAM_LIST     to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPARAM_LIST     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPARAM_LIST     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPARAM_LIST     to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPARAM_LIST     to SPARAM;
grant SELECT                                                                 on SPARAM_LIST     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPARAM_LIST     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SPARAM_LIST     to WR_REFREAD;
grant SELECT                                                                 on SPARAM_LIST     to WR_VIEWACC;
