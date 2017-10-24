

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_BOOL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCORING_QS_BOOL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCORING_QS_BOOL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_BOOL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_BOOL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCORING_QS_BOOL ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCORING_QS_BOOL 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	SCORE_IF_0 NUMBER, 
	SCORE_IF_1 NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SCORING_QS_BOOL ***
 exec bpa.alter_policies('WCS_SCORING_QS_BOOL');


COMMENT ON TABLE BARS.WCS_SCORING_QS_BOOL IS 'Вопрос карты скоринга (бальность по вопросам типа BOOL)';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_BOOL.SCORING_ID IS 'Идентификатор карты скоринга';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_BOOL.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_BOOL.SCORE_IF_0 IS 'Баллы за ответ нет (0)';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_BOOL.SCORE_IF_1 IS 'Баллы за ответ да (1)';




PROMPT *** Create  constraint PK_SCORQSBOOL ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_BOOL ADD CONSTRAINT PK_SCORQSBOOL PRIMARY KEY (SCORING_ID, QUESTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSBOOL_SCORQUESTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_BOOL ADD CONSTRAINT FK_SCORQSBOOL_SCORQUESTS FOREIGN KEY (SCORING_ID, QUESTION_ID)
	  REFERENCES BARS.WCS_SCORING_QUESTIONS (SCORING_ID, QUESTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSBOOL_IF0_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_BOOL MODIFY (SCORE_IF_0 CONSTRAINT CC_SCORQSBOOL_IF0_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSBOOL_IF1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_BOOL MODIFY (SCORE_IF_1 CONSTRAINT CC_SCORQSBOOL_IF1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCORQSBOOL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCORQSBOOL ON BARS.WCS_SCORING_QS_BOOL (SCORING_ID, QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SCORING_QS_BOOL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_BOOL to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_BOOL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_BOOL.sql =========*** E
PROMPT ===================================================================================== 
