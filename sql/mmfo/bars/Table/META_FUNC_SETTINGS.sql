

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_FUNC_SETTINGS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_FUNC_SETTINGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_FUNC_SETTINGS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''META_FUNC_SETTINGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_FUNC_SETTINGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_FUNC_SETTINGS 
   (	ID NUMBER(38,0), 
	TABID NUMBER(38,0), 
	FUNCID NUMBER(38,0), 
	FUNC_TYPE VARCHAR2(30), 
	LINK VARCHAR2(30), 
	MAIN_SET_ID NUMBER(38,0), 
	AFTER_FUNC_ID NUMBER(38,0), 
	MSG VARCHAR2(50), 
	QST VARCHAR2(50), 
	DESCR VARCHAR2(50)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_FUNC_SETTINGS ***
 exec bpa.alter_policies('META_FUNC_SETTINGS');


COMMENT ON TABLE BARS.META_FUNC_SETTINGS IS 'Описание параметров функций';
COMMENT ON COLUMN BARS.META_FUNC_SETTINGS.ID IS 'идентификатор';
COMMENT ON COLUMN BARS.META_FUNC_SETTINGS.TABID IS 'ид таблицы';
COMMENT ON COLUMN BARS.META_FUNC_SETTINGS.FUNCID IS 'вместе с TABID Ключ таблицы NSIFUNCTION , если у нас процедура.';
COMMENT ON COLUMN BARS.META_FUNC_SETTINGS.FUNC_TYPE IS 'описывает тип выполняемой функции. Константы, желательно сделать через перечисление. Например PROC - оракловая процедура. ONLINE - функционал, который будет действовать во время работы(например пересчёт суммы при наведении на числовые столбики и др).,';
COMMENT ON COLUMN BARS.META_FUNC_SETTINGS.LINK IS 'веб ссылка, которая откроется в окне, либо в табе.';
COMMENT ON COLUMN BARS.META_FUNC_SETTINGS.MAIN_SET_ID IS 'ID таблицы META_CALL_SETTINGS';
COMMENT ON COLUMN BARS.META_FUNC_SETTINGS.AFTER_FUNC_ID IS 'Ссылка на id этой таблицы. Функция, которая должна выполнится после текущей, при отсутствии эксепшина.';
COMMENT ON COLUMN BARS.META_FUNC_SETTINGS.MSG IS 'Сообщение';
COMMENT ON COLUMN BARS.META_FUNC_SETTINGS.QST IS 'Вопрос';
COMMENT ON COLUMN BARS.META_FUNC_SETTINGS.DESCR IS 'Семантика, описание';




PROMPT *** Create  constraint SYS_C00138716 ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FUNC_SETTINGS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METAFUNCSETTINGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FUNC_SETTINGS ADD CONSTRAINT PK_METAFUNCSETTINGS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METAFUNCSETTINGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METAFUNCSETTINGS ON BARS.META_FUNC_SETTINGS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_FUNC_SETTINGS ***
grant SELECT                                                                 on META_FUNC_SETTINGS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_FUNC_SETTINGS.sql =========*** En
PROMPT ===================================================================================== 
