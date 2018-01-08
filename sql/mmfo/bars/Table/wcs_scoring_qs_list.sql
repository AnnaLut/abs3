

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_LIST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCORING_QS_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCORING_QS_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_LIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCORING_QS_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCORING_QS_LIST 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	ORD NUMBER, 
	SCORE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SCORING_QS_LIST ***
 exec bpa.alter_policies('WCS_SCORING_QS_LIST');


COMMENT ON TABLE BARS.WCS_SCORING_QS_LIST IS 'Вопрос карты скоринга (бальность по вопросам типа LIST)';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_LIST.SCORING_ID IS 'Идентификатор карты скоринга';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_LIST.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_LIST.ORD IS 'Номер отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_LIST.SCORE IS 'Баллы';




PROMPT *** Create  constraint FK_SCORQSLST_SCORQUESTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_LIST ADD CONSTRAINT FK_SCORQSLST_SCORQUESTS FOREIGN KEY (SCORING_ID, QUESTION_ID)
	  REFERENCES BARS.WCS_SCORING_QUESTIONS (SCORING_ID, QUESTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSLST_QUESTLISTITEMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_LIST ADD CONSTRAINT FK_SCORQSLST_QUESTLISTITEMS FOREIGN KEY (QUESTION_ID, ORD)
	  REFERENCES BARS.WCS_QUESTION_LIST_ITEMS (QUESTION_ID, ORD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSLST_SCORE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_LIST MODIFY (SCORE CONSTRAINT CC_SCORQSLST_SCORE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SCORQSLST ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_LIST ADD CONSTRAINT PK_SCORQSLST PRIMARY KEY (SCORING_ID, QUESTION_ID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCORQSLST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCORQSLST ON BARS.WCS_SCORING_QS_LIST (SCORING_ID, QUESTION_ID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SCORING_QS_LIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_LIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SCORING_QS_LIST to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_LIST to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_LIST.sql =========*** E
PROMPT ===================================================================================== 
