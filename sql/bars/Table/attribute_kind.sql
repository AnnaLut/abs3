

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_KIND.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_KIND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_KIND'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ATTRIBUTE_KIND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_KIND ***
begin 
  execute immediate '
	create table ATTRIBUTE_KIND
	(
		id                     NUMBER(5),
		attribute_code         VARCHAR2(50 CHAR),
		attribute_name         VARCHAR2(300 CHAR),
		attribute_type_id      NUMBER(5),
		object_type_id         NUMBER(5),
		value_type_id          NUMBER(5),
		value_table_owner      VARCHAR2(30 CHAR),
		value_table_name       VARCHAR2(30 CHAR),
		key_column_name        VARCHAR2(30 CHAR),
		value_column_name      VARCHAR2(30 CHAR),
		regular_expression     VARCHAR2(200 CHAR),
		list_type_id           NUMBER(5),
		multy_value_flag       CHAR(1),
		history_saving_mode_id NUMBER(5),
		get_value_function     VARCHAR2(100 CHAR),
		get_values_function    VARCHAR2(100 CHAR),
		set_value_procedure    VARCHAR2(100 CHAR),
		del_value_procedure    VARCHAR2(100 CHAR),
		state_id               NUMBER(5)
	) tablespace BRSDYND';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


-- Add/modify columns 
alter table ATTRIBUTE_KIND modify attribute_code VARCHAR2(50 CHAR);



PROMPT *** ALTER_POLICIES to ATTRIBUTE_KIND ***
 exec bpa.alter_policies('ATTRIBUTE_KIND');


COMMENT ON TABLE BARS.ATTRIBUTE_KIND IS 'Довідник атрибутів об''єктів. Базова таблиця механізму атрибутів';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.ATTRIBUTE_CODE IS 'Код атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.ATTRIBUTE_NAME IS 'Назва атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.ATTRIBUTE_TYPE_ID IS 'Тип атрибуту - стаціонарні атрибути зберігають свої значення в таблицях угод, динамічні атрибути зберігають значення по угоді в вертикальних таблицях, обчислювальні атрибути не зберігають значення, а завжди його вираховують для угоди';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.OBJECT_TYPE_ID IS 'Тип об''єктів, яким властивий даний атрибут';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.VALUE_TYPE_ID IS 'Тип значення атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.VALUE_TABLE_OWNER IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.VALUE_TABLE_NAME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.KEY_COLUMN_NAME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.VALUE_COLUMN_NAME IS 'Назва поля, що зберігає значення атрибуту, в таблиці стаціонарних атрибутів';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.REGULAR_EXPRESSION IS 'Регулярний вираз для перевірки формату при встановленні значення атрибутів (тільки для строкових атрибутів)';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.LIST_TYPE_ID IS 'Ідентифікатор списку, з множини значень якого може вибиратися значення даного атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.MULTY_VALUE_FLAG IS 'Ознака того, що по даному виду атрибуту може бути одночасно декілька значень для однієї угоди';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.HISTORY_SAVING_MODE_ID IS 'Режим збереження історії значень атрибуту (не зберігати історію, зберігати історію значень, зберігати історію значень на дату)';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.GET_VALUE_FUNCTION IS 'Функція, що викликається для отримання значення розрахункового атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.GET_VALUES_FUNCTION IS 'Функція, що викликається для отримання списку значень розрахункового атрибуту, якщо для такого атрибуту допускаються множинні значення';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.SET_VALUE_PROCEDURE IS 'Процедура, що викликається перед встановленням значення атрибуту, або заміняє вставку значення розрахункого атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.DEL_VALUE_PROCEDURE IS 'Процедура, що викликається перед видаленням значення атрибуту, або заміняє видалення значення розрахункого атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.STATE_ID IS 'Статус, в якому перебуває атрибут (режим конструювання, активний, закритий)';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.ID IS 'Ідентифікатор атрибуту';




PROMPT *** Create  constraint FK_ATTRIBUT_REFERENCE_OBJECT_T ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT FK_ATTRIBUT_REFERENCE_OBJECT_T FOREIGN KEY (OBJECT_TYPE_ID)
	  REFERENCES BARS.OBJECT_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ATTRIBUT_REFERENCE_LIST_TYP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT FK_ATTRIBUT_REFERENCE_LIST_TYP FOREIGN KEY (LIST_TYPE_ID)
	  REFERENCES BARS.LIST_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ATTRIBUTE_KIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT UK_ATTRIBUTE_KIND UNIQUE (ATTRIBUTE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ATTRIBUTE_KIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT PK_ATTRIBUTE_KIND PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_HIST_MODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT CC_ATTR_HIST_MODE_NN CHECK (HISTORY_SAVING_MODE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_MULTY_VALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT CC_ATTR_MULTY_VALUE_NN CHECK (MULTY_VALUE_FLAG IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_VALUE_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT CC_ATTR_VALUE_TYPE_NN CHECK (VALUE_TYPE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_OBJ_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT CC_ATTR_OBJ_TYPE_NN CHECK (OBJECT_TYPE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CONSTRAINT CC_ATTR_NAME_NN CHECK (ATTRIBUTE_NAME IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_STATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (STATE_ID CONSTRAINT CC_ATTR_STATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (ATTRIBUTE_TYPE_ID CONSTRAINT CC_ATTR_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (ATTRIBUTE_CODE CONSTRAINT CC_ATTR_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTR_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (ID CONSTRAINT CC_ATTR_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_KIND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ATTRIBUTE_KIND ON BARS.ATTRIBUTE_KIND (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ATTRIBUTE_KIND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ATTRIBUTE_KIND ON BARS.ATTRIBUTE_KIND (ATTRIBUTE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_KIND ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on ATTRIBUTE_KIND  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_KIND.sql =========*** End **
PROMPT ===================================================================================== 
