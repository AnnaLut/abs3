

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SURVEY_GROUP_QUESTIONS.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SURVEY_GROUP_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SURVEY_GROUP_QUESTIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SURVEY_GROUP_QUESTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SURVEY_GROUP_QUESTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SURVEY_GROUP_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS 
   (	SURVEY_ID VARCHAR2(100), 
	SGROUP_ID VARCHAR2(100), 
	RECTYPE_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	DNSHOW_IF VARCHAR2(4000), 
	IS_READONLY VARCHAR2(4000) DEFAULT ''0'', 
	IS_REWRITABLE NUMBER DEFAULT 1, 
	IS_CHECKABLE NUMBER DEFAULT 0, 
	CHECK_PROC VARCHAR2(4000), 
	ORD NUMBER, 
	IS_REQUIRED VARCHAR2(4000) DEFAULT ''0''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SURVEY_GROUP_QUESTIONS ***
 exec bpa.alter_policies('WCS_SURVEY_GROUP_QUESTIONS');


COMMENT ON TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS IS 'Вопросы групы карты-анкеты';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.SURVEY_ID IS 'Идентификатор карты-анкеты';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.SGROUP_ID IS 'Идентификатор групы карты-анкеты';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.RECTYPE_ID IS 'Тип записи (вопрос/раздел)';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.DNSHOW_IF IS 'Условие по которому не показывать вопрос';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.IS_READONLY IS 'Только чтение (null/1/true - OK, 0/false - NOT OK)';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.IS_REWRITABLE IS 'Возможность перезаписи';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.IS_CHECKABLE IS 'Проверяется ли поле';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.CHECK_PROC IS 'Текст проверки';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.ORD IS 'Порядок отображения';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.IS_REQUIRED IS 'Обязателен для заполнения (null/1/true - OK, 0/false - NOT OK)';




PROMPT *** Create  constraint PK_SGRPQUESTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT PK_SGRPQUESTS PRIMARY KEY (SURVEY_ID, SGROUP_ID, QUESTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGRPQUESTS_ISREWRITABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT CC_SGRPQUESTS_ISREWRITABLE CHECK (is_rewritable in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGRPQUESTS_ISCHECKABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT CC_SGRPQUESTS_ISCHECKABLE CHECK (is_checkable in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGRPQUESTS_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS MODIFY (ORD CONSTRAINT CC_SGRPQUESTS_ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SGRPQUESTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SGRPQUESTS ON BARS.WCS_SURVEY_GROUP_QUESTIONS (SURVEY_ID, SGROUP_ID, QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SURVEY_GROUP_QUESTIONS ***
grant SELECT                                                                 on WCS_SURVEY_GROUP_QUESTIONS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SURVEY_GROUP_QUESTIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SURVEY_GROUP_QUESTIONS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SURVEY_GROUP_QUESTIONS to START1;
grant SELECT                                                                 on WCS_SURVEY_GROUP_QUESTIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SURVEY_GROUP_QUESTIONS.sql =======
PROMPT ===================================================================================== 
