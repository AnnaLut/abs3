

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_MATRIX_DECIMAL.sql ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCORING_QS_MATRIX_DECIMAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SCORING_QS_MATRIX_DECIMAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SCORING_QS_MATRIX_DECIMAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SCORING_QS_MATRIX_DECIMAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	AXIS_QID VARCHAR2(100), 
	ORD NUMBER, 
	MIN_VAL NUMBER, 
	MIN_SIGN VARCHAR2(100), 
	MAX_VAL NUMBER, 
	MAX_SIGN VARCHAR2(100)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SCORING_QS_MATRIX_DECIMAL ***
 exec bpa.alter_policies('WCS_SCORING_QS_MATRIX_DECIMAL');


COMMENT ON TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL IS '������ ����� �������� ���� MATRIX (��������� �� ��� ���� DECIMAL)';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DECIMAL.SCORING_ID IS '������������� ����� ��������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DECIMAL.QUESTION_ID IS '������������� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DECIMAL.AXIS_QID IS '������������� �������-��� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DECIMAL.ORD IS '����� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DECIMAL.MIN_VAL IS '���. �������� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DECIMAL.MIN_SIGN IS '���� ���. �������� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DECIMAL.MAX_VAL IS '����. �������� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_MATRIX_DECIMAL.MAX_SIGN IS '���� ����. �������� �������';




PROMPT *** Create  constraint FK_SCORQSMTXDEC_QUESTMTXPARS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT FK_SCORQSMTXDEC_QUESTMTXPARS FOREIGN KEY (QUESTION_ID, AXIS_QID)
	  REFERENCES BARS.WCS_QUESTION_MATRIX_PARAMS (QUESTION_ID, AXIS_QID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSMTXDEC_MINS_STS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT FK_SCORQSMTXDEC_MINS_STS_ID FOREIGN KEY (MIN_SIGN)
	  REFERENCES BARS.WCS_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SCORQSMTXDEC_MAXS_STS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT FK_SCORQSMTXDEC_MAXS_STS_ID FOREIGN KEY (MAX_SIGN)
	  REFERENCES BARS.WCS_SIGN_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTXDEC_MINVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT CC_SCORQSMTXDEC_MINVAL_NN CHECK (MIN_VAL IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTXDEC_MINSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT CC_SCORQSMTXDEC_MINSIGN_NN CHECK (MIN_SIGN IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTXDEC_MAXVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT CC_SCORQSMTXDEC_MAXVAL_NN CHECK (MAX_VAL IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSMTXDEC_MAXSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT CC_SCORQSMTXDEC_MAXSIGN_NN CHECK (MAX_SIGN IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SCORQSMTXDEC ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL ADD CONSTRAINT PK_SCORQSMTXDEC PRIMARY KEY (SCORING_ID, QUESTION_ID, AXIS_QID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177232 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL MODIFY (ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177231 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL MODIFY (AXIS_QID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177230 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL MODIFY (QUESTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177229 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_MATRIX_DECIMAL MODIFY (SCORING_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCORQSMTXDEC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCORQSMTXDEC ON BARS.WCS_SCORING_QS_MATRIX_DECIMAL (SCORING_ID, QUESTION_ID, AXIS_QID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_MATRIX_DECIMAL.sql ====
PROMPT ===================================================================================== 
