

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_MATRIX.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCORING_QS_MATRIX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCORING_QS_MATRIX'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_MATRIX'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_MATRIX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCORING_QS_MATRIX ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCORING_QS_MATRIX 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	SCORE NUMBER, 
	AXIS0_ORD NUMBER, 
	AXIS1_ORD NUMBER, 
	AXIS2_ORD NUMBER, 
	AXIS3_ORD NUMBER, 
	AXIS4_ORD NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SCORING_QS_MATRIX ***
 exec bpa.alter_policies('WCS_SCORING_QS_MATRIX');


COMMENT ON TABLE BARS.WCS_SCORING_QS_MATRIX IS 'Вопрос карты скоринга (бальность по вопросам типа MATRIX)';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX.SCORING_ID IS 'Идентификатор карты скоринга';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX.QUESTION_ID IS 'Идентификатор вопроса';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX.SCORE IS 'Баллы';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX.AXIS0_ORD IS 'Номер ответа по оси 0';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX.AXIS1_ORD IS 'Номер ответа по оси 1';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX.AXIS2_ORD IS 'Номер ответа по оси 2';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX.AXIS3_ORD IS 'Номер ответа по оси 3';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX.AXIS4_ORD IS 'Номер ответа по оси 4';




PROMPT *** Create  constraint CC_SCORQSMTX_SID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX MODIFY (SCORING_ID CONSTRAINT CC_SCORQSMTX_SID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTX_QID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX MODIFY (QUESTION_ID CONSTRAINT CC_SCORQSMTX_QID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTX_SCORE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX MODIFY (SCORE CONSTRAINT CC_SCORQSMTX_SCORE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTX_AXIS0ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX MODIFY (AXIS0_ORD CONSTRAINT CC_SCORQSMTX_AXIS0ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTX_AXIS1ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX MODIFY (AXIS1_ORD CONSTRAINT CC_SCORQSMTX_AXIS1ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_WCS_SCORING_QS_MATRIX ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_WCS_SCORING_QS_MATRIX ON BARS.WCS_SCORING_QS_MATRIX (SCORING_ID, QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SCORING_QS_MATRIX ***
grant SELECT                                                                 on WCS_SCORING_QS_MATRIX to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_MATRIX to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SCORING_QS_MATRIX to START1;
grant SELECT                                                                 on WCS_SCORING_QS_MATRIX to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_MATRIX.sql =========***
PROMPT ===================================================================================== 
