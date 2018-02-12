

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_KIND.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_KIND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_KIND'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ATTRIBUTE_KIND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ATTRIBUTE_KIND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_KIND ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_KIND 
   (	ID NUMBER(5,0), 
	ATTRIBUTE_CODE VARCHAR2(50 CHAR), 
	ATTRIBUTE_NAME VARCHAR2(300 CHAR), 
	ATTRIBUTE_TYPE_ID NUMBER(5,0), 
	OBJECT_TYPE_ID NUMBER(5,0), 
	VALUE_TYPE_ID NUMBER(5,0), 
	VALUE_TABLE_OWNER VARCHAR2(30 CHAR), 
	VALUE_TABLE_NAME VARCHAR2(30 CHAR), 
	KEY_COLUMN_NAME VARCHAR2(30 CHAR), 
	VALUE_COLUMN_NAME VARCHAR2(30 CHAR), 
	REGULAR_EXPRESSION VARCHAR2(4000), 
	LIST_TYPE_ID NUMBER(5,0), 
	SMALL_VALUE_FLAG CHAR(1), 
	VALUE_BY_DATE_FLAG CHAR(1), 
	MULTI_VALUES_FLAG CHAR(1), 
	SAVE_HISTORY_FLAG CHAR(1), 
	GET_VALUE_FUNCTION VARCHAR2(100 CHAR), 
	SET_VALUE_PROCEDURES BARS.STRING_LIST , 
	STATE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 NESTED TABLE SET_VALUE_PROCEDURES STORE AS ATTR_SET_VALUE_HANDLER
 (PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLD ) RETURN AS VALUE';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


-- Add/modify columns 
alter table ATTRIBUTE_KIND modify attribute_code VARCHAR2(50 CHAR);



PROMPT *** ALTER_POLICIES to ATTRIBUTE_KIND ***
 exec bpa.alter_policies('ATTRIBUTE_KIND');


COMMENT ON TABLE BARS.ATTRIBUTE_KIND IS 'Довідник атрибутів об''єктів. Базова таблиця механізму атрибутів';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.ID IS 'Ідентифікатор атрибуту';
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
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.SMALL_VALUE_FLAG IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.VALUE_BY_DATE_FLAG IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.MULTI_VALUES_FLAG IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.SAVE_HISTORY_FLAG IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.GET_VALUE_FUNCTION IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.SET_VALUE_PROCEDURES IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_KIND.STATE_ID IS 'Статус, в якому перебуває атрибут (режим конструювання, активний, закритий)';




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




PROMPT *** Create  constraint SYS_C0025699 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025700 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (ATTRIBUTE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025701 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (ATTRIBUTE_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025702 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025703 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CHECK (ATTRIBUTE_NAME IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UNIQUE (SET_VALUE_PROCEDURES) ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD UNIQUE (SET_VALUE_PROCEDURES)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 or sqlcode=-2329 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025705 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CHECK (VALUE_TYPE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025706 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CHECK (SMALL_VALUE_FLAG IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025707 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CHECK (VALUE_BY_DATE_FLAG IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025708 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CHECK (MULTI_VALUES_FLAG IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025709 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CHECK (SAVE_HISTORY_FLAG IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025704 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_KIND ADD CHECK (OBJECT_TYPE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index UK_ATTRIBUTE_KIND_CODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ATTRIBUTE_KIND_CODE ON BARS.ATTRIBUTE_KIND (ATTRIBUTE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
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



PROMPT *** Create  grants  ATTRIBUTE_KIND ***
grant SELECT                                                                 on ATTRIBUTE_KIND  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ATTRIBUTE_KIND  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_KIND.sql =========*** End **
PROMPT ===================================================================================== 
