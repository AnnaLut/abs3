

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QUESTIONS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCORING_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCORING_QUESTIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QUESTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QUESTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCORING_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCORING_QUESTIONS 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	RESULT_QID VARCHAR2(100), 
	MULTIPLIER NUMBER, 
	ELSE_SCORE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SCORING_QUESTIONS ***
 exec bpa.alter_policies('WCS_SCORING_QUESTIONS');


COMMENT ON TABLE BARS.WCS_SCORING_QUESTIONS IS 'Вопросы карты скоринга';
COMMENT ON COLUMN BARS.WCS_SCORING_QUESTIONS.SCORING_ID IS 'Идентификатор карты скоринга';
COMMENT ON COLUMN BARS.WCS_SCORING_QUESTIONS.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_SCORING_QUESTIONS.RESULT_QID IS 'Идентификатор вопроса-результата вычисления скор. балла';
COMMENT ON COLUMN BARS.WCS_SCORING_QUESTIONS.MULTIPLIER IS 'Весовой коэффициент';
COMMENT ON COLUMN BARS.WCS_SCORING_QUESTIONS.ELSE_SCORE IS 'Cкор. балла если не выполнились условия разбивки';




PROMPT *** Create  constraint PK_SCORINGQUESTIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QUESTIONS ADD CONSTRAINT PK_SCORINGQUESTIONS PRIMARY KEY (SCORING_ID, QUESTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQUESTS_SID_SCORS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QUESTIONS ADD CONSTRAINT FK_SCORQUESTS_SID_SCORS_ID FOREIGN KEY (SCORING_ID)
	  REFERENCES BARS.WCS_SCORINGS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQUESTS_QID_QUESTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QUESTIONS ADD CONSTRAINT FK_SCORQUESTS_QID_QUESTS_ID FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQUESTS_RQID_QUESTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QUESTIONS ADD CONSTRAINT FK_SCORQUESTS_RQID_QUESTS_ID FOREIGN KEY (RESULT_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCORINGQUESTIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCORINGQUESTIONS ON BARS.WCS_SCORING_QUESTIONS (SCORING_ID, QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SCORING_QUESTIONS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QUESTIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SCORING_QUESTIONS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QUESTIONS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QUESTIONS.sql =========***
PROMPT ===================================================================================== 
