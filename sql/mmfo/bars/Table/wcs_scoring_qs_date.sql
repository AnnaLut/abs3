

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_DATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCORING_QS_DATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCORING_QS_DATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_DATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_DATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCORING_QS_DATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCORING_QS_DATE 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	ORD NUMBER, 
	MIN_VAL DATE, 
	MIN_SIGN VARCHAR2(100), 
	MAX_VAL DATE, 
	MAX_SIGN VARCHAR2(100), 
	SCORE NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SCORING_QS_DATE ***
 exec bpa.alter_policies('WCS_SCORING_QS_DATE');


COMMENT ON TABLE BARS.WCS_SCORING_QS_DATE IS 'Вопрос карты скоринга (бальность по вопросам типа DATE)';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_DATE.SCORING_ID IS 'Идентификатор карты скоринга';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_DATE.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_DATE.ORD IS 'Номер отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_DATE.MIN_VAL IS 'Мин. значение отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_DATE.MIN_SIGN IS 'Знак мин. значения отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_DATE.MAX_VAL IS 'Макс. значение отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_DATE.MAX_SIGN IS 'Знак макс. значения отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_DATE.SCORE IS 'Баллы';




PROMPT *** Create  constraint PK_SCORQSDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_DATE ADD CONSTRAINT PK_SCORQSDAT PRIMARY KEY (SCORING_ID, QUESTION_ID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSDAT_MINVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_DATE MODIFY (MIN_VAL CONSTRAINT CC_SCORQSDAT_MINVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSDAT_MINSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_DATE MODIFY (MIN_SIGN CONSTRAINT CC_SCORQSDAT_MINSIGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSDAT_MAXVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_DATE MODIFY (MAX_VAL CONSTRAINT CC_SCORQSDAT_MAXVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSDAT_MAXSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_DATE MODIFY (MAX_SIGN CONSTRAINT CC_SCORQSDAT_MAXSIGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSDAT_SCORE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_DATE MODIFY (SCORE CONSTRAINT CC_SCORQSDAT_SCORE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCORQSDAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCORQSDAT ON BARS.WCS_SCORING_QS_DATE (SCORING_ID, QUESTION_ID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SCORING_QS_DATE ***
grant SELECT                                                                 on WCS_SCORING_QS_DATE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_DATE to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_DATE to START1;
grant SELECT                                                                 on WCS_SCORING_QS_DATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_DATE.sql =========*** E
PROMPT ===================================================================================== 
