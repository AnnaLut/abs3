

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_MATRIX_DATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCORING_QS_MATRIX_DATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCORING_QS_MATRIX_DATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_MATRIX_DATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_MATRIX_DATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCORING_QS_MATRIX_DATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCORING_QS_MATRIX_DATE 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	AXIS_QID VARCHAR2(100), 
	ORD NUMBER, 
	MIN_VAL DATE, 
	MIN_SIGN VARCHAR2(100), 
	MAX_VAL DATE, 
	MAX_SIGN VARCHAR2(100)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SCORING_QS_MATRIX_DATE ***
 exec bpa.alter_policies('WCS_SCORING_QS_MATRIX_DATE');


COMMENT ON TABLE BARS.WCS_SCORING_QS_MATRIX_DATE IS 'Вопрос карты скоринга типа MATRIX (бальность по оси типа DATE)';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DATE.SCORING_ID IS 'Идентификатор карты скоринга';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DATE.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DATE.AXIS_QID IS 'Идентификатор вопроса-оси матрицы';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DATE.ORD IS 'Номер отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DATE.MIN_VAL IS 'Мин. значение отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DATE.MIN_SIGN IS 'Знак мин. значения отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DATE.MAX_VAL IS 'Макс. значение отрезка';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DATE.MAX_SIGN IS 'Знак макс. значения отрезка';




PROMPT *** Create  constraint PK_SCORQSMTXDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DATE ADD CONSTRAINT PK_SCORQSMTXDAT PRIMARY KEY (SCORING_ID, QUESTION_ID, AXIS_QID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSMTXDAT_SCORQUESTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DATE ADD CONSTRAINT FK_SCORQSMTXDAT_SCORQUESTS FOREIGN KEY (SCORING_ID, QUESTION_ID)
	  REFERENCES BARS.WCS_SCORING_QUESTIONS (SCORING_ID, QUESTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTXDAT_MAXSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DATE MODIFY (MAX_SIGN CONSTRAINT CC_SCORQSMTXDAT_MAXSIGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTXDAT_MAXVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DATE MODIFY (MAX_VAL CONSTRAINT CC_SCORQSMTXDAT_MAXVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTXDAT_MINSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DATE MODIFY (MIN_SIGN CONSTRAINT CC_SCORQSMTXDAT_MINSIGN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTXDAT_MINVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DATE MODIFY (MIN_VAL CONSTRAINT CC_SCORQSMTXDAT_MINVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSMTXDAT_MAXS_STS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DATE ADD CONSTRAINT FK_SCORQSMTXDAT_MAXS_STS_ID FOREIGN KEY (MAX_SIGN)
	  REFERENCES BARS.WCS_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSMTXDAT_MINS_STS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DATE ADD CONSTRAINT FK_SCORQSMTXDAT_MINS_STS_ID FOREIGN KEY (MIN_SIGN)
	  REFERENCES BARS.WCS_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSMTXDAT_QUESTMTXPARS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DATE ADD CONSTRAINT FK_SCORQSMTXDAT_QUESTMTXPARS FOREIGN KEY (QUESTION_ID, AXIS_QID)
	  REFERENCES BARS.WCS_QUESTION_MATRIX_PARAMS (QUESTION_ID, AXIS_QID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCORQSMTXDAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCORQSMTXDAT ON BARS.WCS_SCORING_QS_MATRIX_DATE (SCORING_ID, QUESTION_ID, AXIS_QID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SCORING_QS_MATRIX_DATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_MATRIX_DATE to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_MATRIX_DATE to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_MATRIX_DATE.sql =======
PROMPT ===================================================================================== 
