declare
    l_attribute_column_exists_flag varchar2(1 char) := 'N';
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    begin
        select 'Y'
        into   l_attribute_column_exists_flag
        from   user_tab_columns t
        where  t.table_name = 'ATTRIBUTE_KIND' and
               t.column_name = 'ATTRIBUTE_COLUMN_NAME';
    exception
        when no_data_found then
             null;
    end;

    if (l_attribute_column_exists_flag = 'N') then
        begin
            execute immediate
            'CREATE TABLE TMP_ATTRIBUTE_KIND  (
               ID                   NUMBER(38)                      NOT NULL,
               ATTRIBUTE_CODE       VARCHAR2(50 CHAR)               NOT NULL,
               ATTRIBUTE_NAME       VARCHAR2(4000 BYTE)             CONSTRAINT CC_ATTR_NAME_NN NOT NULL DEFERRABLE INITIALLY DEFERRED,
               ATTRIBUTE_TYPE_ID    NUMBER(5)                       NOT NULL,
               OBJECT_TYPE_ID       NUMBER(38)                      CONSTRAINT CC_ATTR_OBJ_TYPE_NN NOT NULL DEFERRABLE INITIALLY DEFERRED,
               VALUE_TYPE_ID        NUMBER(5)                       CONSTRAINT CC_ATTR_VALUE_TYPE_NN NOT NULL DEFERRABLE INITIALLY DEFERRED,
               VALUE_TABLE_OWNER    VARCHAR2(30 CHAR),
               VALUE_TABLE_NAME     VARCHAR2(30 CHAR),
               ATTRIBUTE_COLUMN_NAME VARCHAR2(30 CHAR),
               KEY_COLUMN_NAME      VARCHAR2(30 CHAR),
               VALUE_COLUMN_NAME    VARCHAR2(30 CHAR),
               REGULAR_EXPRESSION   VARCHAR2(4000 BYTE),
               LIST_TYPE_ID         NUMBER(38),
               SMALL_VALUE_FLAG     CHAR(1 BYTE)                    CONSTRAINT CC_ATTR_SMALL_VALUE_NN NOT NULL DEFERRABLE INITIALLY DEFERRED,
               VALUE_BY_DATE_FLAG   CHAR(1 BYTE)                    CONSTRAINT CC_ATTR_VAL_BY_DATE_NN NOT NULL DEFERRABLE INITIALLY DEFERRED,
               MULTI_VALUES_FLAG    CHAR(1 BYTE)                    CONSTRAINT CC_ATTR_MULTY_VALUE_NN NOT NULL DEFERRABLE INITIALLY DEFERRED,
               SAVE_HISTORY_FLAG    CHAR(1 BYTE)                    CONSTRAINT CC_ATTR_HIST_MODE_NN NOT NULL DEFERRABLE INITIALLY DEFERRED,
               GET_VALUE_FUNCTION   VARCHAR2(100 CHAR),
               SET_VALUE_PROCEDURES VARCHAR2(4000 BYTE),
               STATE_ID             NUMBER(5)                       NOT NULL
            )
            TABLESPACE BRSMDLD';
        exception
            when name_already_used then
                 null;
        end;

        lock table attribute_kind in exclusive mode;

        execute immediate
        'insert into tmp_attribute_kind
         select id, attribute_code, attribute_name, attribute_type_id, object_type_id, value_type_id, value_table_owner, value_table_name,
                null, key_column_name, value_column_name, regular_expression, list_type_id, small_value_flag, value_by_date_flag, multi_values_flag,
                save_history_flag, get_value_function, tools.words_to_string(set_value_procedures, '';''), state_id
         from attribute_kind';

         execute immediate 'drop table attribute_kind';
         execute immediate 'rename tmp_attribute_kind to attribute_kind';
    end if;
end;
/

COMMENT ON TABLE ATTRIBUTE_KIND IS 'Довідник атрибутів об''єктів. Базова таблиця механізму атрибутів';
COMMENT ON COLUMN ATTRIBUTE_KIND.ID IS 'Ідентифікатор атрибуту';
COMMENT ON COLUMN ATTRIBUTE_KIND.ATTRIBUTE_CODE IS 'Код атрибуту';
COMMENT ON COLUMN ATTRIBUTE_KIND.ATTRIBUTE_NAME IS 'Назва атрибуту';
COMMENT ON COLUMN ATTRIBUTE_KIND.ATTRIBUTE_TYPE_ID IS 'Тип атрибуту - стаціонарні атрибути зберігають свої значення в таблицях угод, динамічні атрибути зберігають значення по угоді в вертикальних таблицях, обчислювальні атрибути не зберігають значення, а завжди його вираховують для угоди';
COMMENT ON COLUMN ATTRIBUTE_KIND.OBJECT_TYPE_ID IS 'Тип об''єктів, яким властивий даний атрибут';
COMMENT ON COLUMN ATTRIBUTE_KIND.VALUE_TYPE_ID IS 'Тип значення атрибуту';
COMMENT ON COLUMN ATTRIBUTE_KIND.VALUE_TABLE_OWNER IS 'Схема-власник таблиці, що зберігає значення об''єктів';
COMMENT ON COLUMN ATTRIBUTE_KIND.VALUE_TABLE_NAME IS 'Назва таблиці, що зберігеє значення об''єктів';
COMMENT ON COLUMN ATTRIBUTE_KIND.ATTRIBUTE_COLUMN_NAME IS 'Назва поля, що зберігає ідентифікатор типу атрибуту в таблиці, що зберігає фіксовані значення множинних атрибутів';
COMMENT ON COLUMN ATTRIBUTE_KIND.KEY_COLUMN_NAME IS 'Назва поля, що зберігає унікальний ідентифікатор об''єкта';
COMMENT ON COLUMN ATTRIBUTE_KIND.VALUE_COLUMN_NAME IS 'Назва поля, що зберігає значення атрибуту, в таблиці стаціонарних атрибутів';
COMMENT ON COLUMN ATTRIBUTE_KIND.LIST_TYPE_ID IS 'Ідентифікатор списку, з множини значень якого може вибиратися значення даного атрибуту';
COMMENT ON COLUMN ATTRIBUTE_KIND.MULTI_VALUES_FLAG IS 'Ознака того, що по даному виду атрибуту може бути одночасно декілька значень для однієї угоди';
COMMENT ON COLUMN ATTRIBUTE_KIND.SAVE_HISTORY_FLAG IS 'Режим збереження історії значень атрибуту (не зберігати історію, зберігати історію значень, зберігати історію значень на дату)';
COMMENT ON COLUMN ATTRIBUTE_KIND.GET_VALUE_FUNCTION IS 'Функція, що викликається для отримання значення розрахункового атрибуту';
COMMENT ON COLUMN ATTRIBUTE_KIND.SET_VALUE_PROCEDURES IS 'Перелік процедур (через крапку з комою), що викликаються перед встановленням значення атрибуту';
COMMENT ON COLUMN ATTRIBUTE_KIND.STATE_ID IS 'Статус, в якому перебуває атрибут (режим конструювання, активний, закритий)';

begin ddl_utl.create_primary_key('ALTER TABLE ATTRIBUTE_KIND ADD CONSTRAINT PK_ATTRIBUTE_KIND PRIMARY KEY (ID)'); end;
/
begin ddl_utl.create_unique_key('ALTER TABLE ATTRIBUTE_KIND ADD CONSTRAINT UK_ATTRIBUTE_KIND UNIQUE (ATTRIBUTE_CODE)'); end;
/
begin ddl_utl.add_constraint('ALTER TABLE ATTRIBUTE_KIND ADD CONSTRAINT FK_ATTR_KIND_REF_OBJECT_TYPE FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJECT_TYPE (ID)'); end;
/
begin ddl_utl.add_constraint('ALTER TABLE ATTRIBUTE_KIND ADD CONSTRAINT FK_ATTR_KIND_REF_LIST_TYPE FOREIGN KEY (LIST_TYPE_ID) REFERENCES LIST_TYPE (ID)'); end;
/
begin ddl_utl.add_constraint('ALTER TABLE ATTRIBUTE_VALUE ADD CONSTRAINT FK_ATTR_DATA_REF_ATTR_KIND FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE_KIND (ID) NOVALIDATE'); end;
/
begin ddl_utl.add_constraint('ALTER TABLE ATTRIBUTE_VALUE_BY_DATE ADD CONSTRAINT FK_ATTR_VAL_BYD_REF_ATTR_KIND FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE_KIND (ID) NOVALIDATE'); end;
/
begin ddl_utl.add_constraint('ALTER TABLE ATTRIBUTE_SMALL_VALUE ADD CONSTRAINT FK_SMALL_DATA_REF_ATTR_KIND FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE_KIND (ID)'); end;
/
begin ddl_utl.add_constraint('ALTER TABLE ATTRIBUTE_HISTORY ADD CONSTRAINT FK_OBJ_ATTR_HIST_REF_ATTR_KIND FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE_KIND (ID) NOVALIDATE'); end;
/
begin ddl_utl.add_constraint('ALTER TABLE ATTRIBUTE_DOMAIN ADD CONSTRAINT FK_ATTR_DOMAIN_REF_ATTR_KIND FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE_KIND (ID)'); end;
/

PROMPT *** Create  grants  ATTRIBUTE_KIND ***
grant SELECT                                                                 on ATTRIBUTE_KIND  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ATTRIBUTE_KIND  to BARS_DM;
---