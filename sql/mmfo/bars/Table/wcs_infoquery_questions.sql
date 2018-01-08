

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_INFOQUERY_QUESTIONS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_INFOQUERY_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_INFOQUERY_QUESTIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_INFOQUERY_QUESTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_INFOQUERY_QUESTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_INFOQUERY_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_INFOQUERY_QUESTIONS 
   (	IQUERY_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	IS_REQUIRED NUMBER DEFAULT 1, 
	IS_CHECKABLE NUMBER DEFAULT 0, 
	CHECK_PROC VARCHAR2(4000), 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_INFOQUERY_QUESTIONS ***
 exec bpa.alter_policies('WCS_INFOQUERY_QUESTIONS');


COMMENT ON TABLE BARS.WCS_INFOQUERY_QUESTIONS IS 'Вопросы информационных запросов';
COMMENT ON COLUMN BARS.WCS_INFOQUERY_QUESTIONS.IQUERY_ID IS 'Идентификатор информационного запроса';
COMMENT ON COLUMN BARS.WCS_INFOQUERY_QUESTIONS.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_INFOQUERY_QUESTIONS.IS_REQUIRED IS 'Обязателен ли для заполнения';
COMMENT ON COLUMN BARS.WCS_INFOQUERY_QUESTIONS.IS_CHECKABLE IS 'Проверяется ли поле';
COMMENT ON COLUMN BARS.WCS_INFOQUERY_QUESTIONS.CHECK_PROC IS 'Текст проверки';
COMMENT ON COLUMN BARS.WCS_INFOQUERY_QUESTIONS.ORD IS 'Порядок';




PROMPT *** Create  constraint CC_INFOQQUESTS_REQUIRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERY_QUESTIONS ADD CONSTRAINT CC_INFOQQUESTS_REQUIRED CHECK (is_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INFOQQUESTS_CHECKABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERY_QUESTIONS ADD CONSTRAINT CC_INFOQQUESTS_CHECKABLE CHECK (is_checkable in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSINFOQUERYQUESTIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERY_QUESTIONS ADD CONSTRAINT PK_WCSINFOQUERYQUESTIONS PRIMARY KEY (IQUERY_ID, QUESTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_IQQUESTIONS_IQID_IQS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERY_QUESTIONS ADD CONSTRAINT FK_IQQUESTIONS_IQID_IQS_ID FOREIGN KEY (IQUERY_ID)
	  REFERENCES BARS.WCS_INFOQUERIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_IQQUESTIONS_QID_QUEST_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERY_QUESTIONS ADD CONSTRAINT FK_IQQUESTIONS_QID_QUEST_ID FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSINFOQUERYQUESTIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSINFOQUERYQUESTIONS ON BARS.WCS_INFOQUERY_QUESTIONS (IQUERY_ID, QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_INFOQUERY_QUESTIONS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_INFOQUERY_QUESTIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_INFOQUERY_QUESTIONS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_INFOQUERY_QUESTIONS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_INFOQUERY_QUESTIONS.sql =========*
PROMPT ===================================================================================== 
