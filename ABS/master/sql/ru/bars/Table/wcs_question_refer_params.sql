

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_QUESTION_REFER_PARAMS.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_QUESTION_REFER_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_QUESTION_REFER_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_QUESTION_REFER_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_QUESTION_REFER_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_QUESTION_REFER_PARAMS 
   (	QUESTION_ID VARCHAR2(100), 
	TAB_NAME VARCHAR2(255), 
	KEY_FIELD VARCHAR2(255), 
	SEMANTIC_FIELD VARCHAR2(255), 
	SHOW_FIELDS VARCHAR2(255), 
	WHERE_CLAUSE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_QUESTION_REFER_PARAMS ***
 exec bpa.alter_policies('WCS_QUESTION_REFER_PARAMS');


COMMENT ON TABLE BARS.WCS_QUESTION_REFER_PARAMS IS 'Описание списочного вопроса';
COMMENT ON COLUMN BARS.WCS_QUESTION_REFER_PARAMS.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_QUESTION_REFER_PARAMS.TAB_NAME IS 'Найменование таблицы справочника';
COMMENT ON COLUMN BARS.WCS_QUESTION_REFER_PARAMS.KEY_FIELD IS 'Ключевое поле';
COMMENT ON COLUMN BARS.WCS_QUESTION_REFER_PARAMS.SEMANTIC_FIELD IS 'Поле семантики';
COMMENT ON COLUMN BARS.WCS_QUESTION_REFER_PARAMS.SHOW_FIELDS IS 'Поля для отображения (перечисление через запятую)';
COMMENT ON COLUMN BARS.WCS_QUESTION_REFER_PARAMS.WHERE_CLAUSE IS 'Условие отбора (включая слово where)';




PROMPT *** Create  constraint FK_QUEST_META_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_REFER_PARAMS ADD CONSTRAINT FK_QUEST_META_NAME FOREIGN KEY (TAB_NAME)
	  REFERENCES BARS.META_TABLES (TABNAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_QUEST_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_REFER_PARAMS ADD CONSTRAINT FK_QUEST_PARAMS FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_QUESTREFERPARS_TABNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_REFER_PARAMS ADD CONSTRAINT CC_QUESTREFERPARS_TABNAME_NN CHECK (TAB_NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_QUESTIONREFERPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_REFER_PARAMS ADD CONSTRAINT PK_QUESTIONREFERPARAMS PRIMARY KEY (QUESTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177415 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_QUESTION_REFER_PARAMS MODIFY (QUESTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_QUESTIONREFERPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_QUESTIONREFERPARAMS ON BARS.WCS_QUESTION_REFER_PARAMS (QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_QUESTION_REFER_PARAMS ***
grant SELECT                                                                 on WCS_QUESTION_REFER_PARAMS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_QUESTION_REFER_PARAMS.sql ========
PROMPT ===================================================================================== 
