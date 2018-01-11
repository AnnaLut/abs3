

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SOLVENCY_QUESTIONS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SOLVENCY_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SOLVENCY_QUESTIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SOLVENCY_QUESTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SOLVENCY_QUESTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SOLVENCY_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SOLVENCY_QUESTIONS 
   (	SOLVENCY_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SOLVENCY_QUESTIONS ***
 exec bpa.alter_policies('WCS_SOLVENCY_QUESTIONS');


COMMENT ON TABLE BARS.WCS_SOLVENCY_QUESTIONS IS 'Вопросы карты кредитоспособности';
COMMENT ON COLUMN BARS.WCS_SOLVENCY_QUESTIONS.SOLVENCY_ID IS 'Идентификатор карты кредитоспособности';
COMMENT ON COLUMN BARS.WCS_SOLVENCY_QUESTIONS.QUESTION_ID IS 'Идентификатор вопроса';




PROMPT *** Create  constraint PK_SOLVQUESTIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SOLVENCY_QUESTIONS ADD CONSTRAINT PK_SOLVQUESTIONS PRIMARY KEY (SOLVENCY_ID, QUESTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOLVQUESTIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOLVQUESTIONS ON BARS.WCS_SOLVENCY_QUESTIONS (SOLVENCY_ID, QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SOLVENCY_QUESTIONS ***
grant SELECT                                                                 on WCS_SOLVENCY_QUESTIONS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SOLVENCY_QUESTIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SOLVENCY_QUESTIONS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SOLVENCY_QUESTIONS to START1;
grant SELECT                                                                 on WCS_SOLVENCY_QUESTIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SOLVENCY_QUESTIONS.sql =========**
PROMPT ===================================================================================== 
