

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SURVEY_ANSWER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SURVEY_ANSWER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SURVEY_ANSWER'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SURVEY_ANSWER'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SURVEY_ANSWER'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SURVEY_ANSWER ***
begin 
  execute immediate '
  CREATE TABLE BARS.SURVEY_ANSWER 
   (	SESSION_ID NUMBER(38,0), 
	QUEST_ID NUMBER(38,0), 
	ANSWER_POS NUMBER(8,0), 
	ANSWER_OPT NUMBER(38,0), 
	ANSWER_ID NUMBER(38,0), 
	ANSWER_CHAR VARCHAR2(250), 
	ANSWER_NUMB NUMBER(38,0), 
	ANSWER_DATE DATE, 
	ANSWER_NULL NUMBER(1,0) DEFAULT 0, 
	QUEST_ID_P NUMBER(*,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SURVEY_ANSWER ***
 exec bpa.alter_policies('SURVEY_ANSWER');


COMMENT ON TABLE BARS.SURVEY_ANSWER IS 'Ответы на вопросы анкет клиентов';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.SESSION_ID IS 'Номер сессии';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.QUEST_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.ANSWER_POS IS 'Порядковый номер ответа на конкретный вопрос';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.ANSWER_OPT IS 'Идентификатор варианта ответа';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.ANSWER_ID IS 'Значение ключа из внешнего спр-ка';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.ANSWER_CHAR IS 'Ответ (произвольный текст)';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.ANSWER_NUMB IS 'Ответ (произвольное число)';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.ANSWER_DATE IS 'Ответ (произвольная дата)';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.ANSWER_NULL IS 'Признак того, что клиент не ответил на вопрос';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.QUEST_ID_P IS 'Программный код вопроса';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.BRANCH IS '';
COMMENT ON COLUMN BARS.SURVEY_ANSWER.KF IS '';




PROMPT *** Create  constraint PK_SURVEYANSWER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER ADD CONSTRAINT PK_SURVEYANSWER PRIMARY KEY (SESSION_ID, QUEST_ID, ANSWER_POS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWER_ANSWERNULL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER ADD CONSTRAINT CC_SURVEYANSWER_ANSWERNULL CHECK (answer_null IN (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWER_FMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER ADD CONSTRAINT CC_SURVEYANSWER_FMT CHECK ( 1 = DECODE(answer_opt,  NULL, 0, 1) 
      + DECODE(answer_id,   NULL, 0, 1) 
      + DECODE(answer_char, NULL, 0, 1) 
      + DECODE(answer_numb, NULL, 0, 1) 
      + DECODE(answer_date, NULL, 0, 1) 
	  + answer_null ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWER_SESSIONID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER MODIFY (SESSION_ID CONSTRAINT CC_SURVEYANSWER_SESSIONID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWER_QUESTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER MODIFY (QUEST_ID CONSTRAINT CC_SURVEYANSWER_QUESTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWER_ANSWERPOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER MODIFY (ANSWER_POS CONSTRAINT CC_SURVEYANSWER_ANSWERPOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWER_ANSWERNULL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER MODIFY (ANSWER_NULL CONSTRAINT CC_SURVEYANSWER_ANSWERNULL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWER_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER MODIFY (BRANCH CONSTRAINT CC_SURVEYANSWER_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SURVEYANSWER_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER MODIFY (KF CONSTRAINT CC_SURVEYANSWER_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SURVEYANSWER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SURVEYANSWER ON BARS.SURVEY_ANSWER (SESSION_ID, QUEST_ID, ANSWER_POS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SURVEY_ANSWER ***
grant SELECT                                                                 on SURVEY_ANSWER   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_ANSWER   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SURVEY_ANSWER   to BARS_DM;
grant SELECT                                                                 on SURVEY_ANSWER   to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_ANSWER   to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SURVEY_ANSWER   to RCC_DEAL;
grant SELECT                                                                 on SURVEY_ANSWER   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SURVEY_ANSWER   to WR_ALL_RIGHTS;
grant DELETE                                                                 on SURVEY_ANSWER   to WR_CREDIT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SURVEY_ANSWER.sql =========*** End ***
PROMPT ===================================================================================== 
