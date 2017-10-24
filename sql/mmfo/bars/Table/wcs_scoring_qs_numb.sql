

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_NUMB.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCORING_QS_NUMB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCORING_QS_NUMB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_NUMB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_NUMB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCORING_QS_NUMB ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCORING_QS_NUMB 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	ORD NUMBER, 
	MIN_VAL NUMBER, 
	MIN_SIGN VARCHAR2(100), 
	MAX_VAL NUMBER, 
	MAX_SIGN VARCHAR2(100), 
	SCORE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SCORING_QS_NUMB ***
 exec bpa.alter_policies('WCS_SCORING_QS_NUMB');


COMMENT ON TABLE BARS.WCS_SCORING_QS_NUMB IS 'Вопрос карты скоринга (бальность по вопросам типа NUMB)';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.SCORING_ID IS 'Идентификатор карты скоринга';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.ORD IS 'Номер отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.MIN_VAL IS 'Мин. значение отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.MIN_SIGN IS 'Знак мин. значения отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.MAX_VAL IS 'Макс. значение отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.MAX_SIGN IS 'Знак макс. значения отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.SCORE IS 'Баллы';




PROMPT *** Create  constraint PK_SCORQSNUMB ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB ADD CONSTRAINT PK_SCORQSNUMB PRIMARY KEY (SCORING_ID, QUESTION_ID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSNUMB_SCORQUESTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB ADD CONSTRAINT FK_SCORQSNUMB_SCORQUESTS FOREIGN KEY (SCORING_ID, QUESTION_ID)
	  REFERENCES BARS.WCS_SCORING_QUESTIONS (SCORING_ID, QUESTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSNUMB_SCORE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB MODIFY (SCORE CONSTRAINT CC_SCORQSNUMB_SCORE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSNUMB_MAXSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB MODIFY (MAX_SIGN CONSTRAINT CC_SCORQSNUMB_MAXSIGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSNUMB_MAXVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB MODIFY (MAX_VAL CONSTRAINT CC_SCORQSNUMB_MAXVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSNUMB_MINSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB MODIFY (MIN_SIGN CONSTRAINT CC_SCORQSNUMB_MINSIGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSNUMB_MINVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB MODIFY (MIN_VAL CONSTRAINT CC_SCORQSNUMB_MINVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSNUMB_MINS_STYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB ADD CONSTRAINT FK_SCORQSNUMB_MINS_STYPES_ID FOREIGN KEY (MIN_SIGN)
	  REFERENCES BARS.WCS_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSNUMB_MAXS_STYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB ADD CONSTRAINT FK_SCORQSNUMB_MAXS_STYPES_ID FOREIGN KEY (MAX_SIGN)
	  REFERENCES BARS.WCS_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCORQSNUMB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCORQSNUMB ON BARS.WCS_SCORING_QS_NUMB (SCORING_ID, QUESTION_ID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SCORING_QS_NUMB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_NUMB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SCORING_QS_NUMB to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_NUMB to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_NUMB.sql =========*** E
PROMPT ===================================================================================== 
