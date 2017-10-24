

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_KIND_BAK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_KIND_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_KIND_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_KIND_BAK 
   (	ID NUMBER(5,0), 
	ATTRIBUTE_CODE VARCHAR2(30 CHAR), 
	ATTRIBUTE_NAME VARCHAR2(300 CHAR), 
	ATTRIBUTE_TYPE_ID NUMBER(5,0), 
	OBJECT_TYPE_ID NUMBER(5,0), 
	VALUE_TYPE_ID NUMBER(5,0), 
	VALUE_TABLE_OWNER VARCHAR2(30 CHAR), 
	VALUE_TABLE_NAME VARCHAR2(30 CHAR), 
	KEY_COLUMN_NAME VARCHAR2(30 CHAR), 
	VALUE_COLUMN_NAME VARCHAR2(30 CHAR), 
	REGULAR_EXPRESSION VARCHAR2(200 CHAR), 
	LIST_TYPE_ID NUMBER(5,0), 
	MULTY_VALUE_FLAG CHAR(1), 
	HISTORY_SAVING_MODE_ID NUMBER(5,0), 
	GET_VALUE_FUNCTION VARCHAR2(100 CHAR), 
	GET_VALUES_FUNCTION VARCHAR2(100 CHAR), 
	SET_VALUE_PROCEDURE VARCHAR2(100 CHAR), 
	DEL_VALUE_PROCEDURE VARCHAR2(100 CHAR), 
	STATE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_KIND_BAK ***
 exec bpa.alter_policies('ATTRIBUTE_KIND_BAK');


COMMENT ON TABLE BARS.ATTRIBUTE_KIND_BAK IS 'Довідник атрибутів об'єктів. Базова таблиця механізму атрибутів';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.GET_VALUE_FUNCTION IS 'Функція, що викликається для отримання значення розрахункового атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.GET_VALUES_FUNCTION IS 'Функція, що викликається для отримання списку значень розрахункового атрибуту, якщо для такого атрибуту допускаються множинні значення';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.SET_VALUE_PROCEDURE IS 'Процедура, що викликається перед встановленням значення атрибуту, або заміняє вставку значення розрахункого атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.DEL_VALUE_PROCEDURE IS 'Процедура, що викликається перед видаленням значення атрибуту, або заміняє видалення значення розрахункого атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.STATE_ID IS 'Статус, в якому перебуває атрибут (режим конструювання, активний, закритий)';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.ID IS 'Ідентифікатор атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.ATTRIBUTE_CODE IS 'Код атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.ATTRIBUTE_NAME IS 'Назва атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.ATTRIBUTE_TYPE_ID IS 'Тип атрибуту - стаціонарні атрибути зберігають свої значення в таблицях угод, динамічні атрибути зберігають значення по угоді в вертикальних таблицях, обчислювальні атрибути не зберігають значення, а завжди його вираховують для угоди';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.OBJECT_TYPE_ID IS 'Тип об'єктів, яким властивий даний атрибут';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.VALUE_TYPE_ID IS 'Тип значення атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.VALUE_TABLE_OWNER IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.VALUE_TABLE_NAME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.KEY_COLUMN_NAME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.VALUE_COLUMN_NAME IS 'Назва поля, що зберігає значення атрибуту, в таблиці стаціонарних атрибутів';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.REGULAR_EXPRESSION IS 'Регулярний вираз для перевірки формату при встановленні значення атрибутів (тільки для строкових атрибутів)';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.LIST_TYPE_ID IS 'Ідентифікатор списку, з множини значень якого може вибиратися значення даного атрибуту';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.MULTY_VALUE_FLAG IS 'Ознака того, що по даному виду атрибуту може бути одночасно декілька значень для однієї угоди';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND_BAK.HISTORY_SAVING_MODE_ID IS 'Режим збереження історії значень атрибуту (не зберігати історію, зберігати історію значень, зберігати історію значень на дату)';



PROMPT *** Create  grants  ATTRIBUTE_KIND_BAK ***
grant SELECT                                                                 on ATTRIBUTE_KIND_BAK to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_KIND_BAK.sql =========*** En
PROMPT ===================================================================================== 
