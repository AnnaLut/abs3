

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_NUMB.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCORING_QS_NUMB ***


BEGIN 
        execute immediate  
          'begin  
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


COMMENT ON TABLE BARS.WCS_SCORING_QS_NUMB IS '������ ����� �������� (��������� �� �������� ���� NUMB)';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.SCORING_ID IS '������������� ����� ��������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.QUESTION_ID IS '������������� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.ORD IS '����� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.MIN_VAL IS '���. �������� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.MIN_SIGN IS '���� ���. �������� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.MAX_VAL IS '����. �������� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.MAX_SIGN IS '���� ����. �������� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_NUMB.SCORE IS '�����';




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




PROMPT *** Create  constraint CC_SCORQSNUMB_SCORE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB ADD CONSTRAINT CC_SCORQSNUMB_SCORE_NN CHECK (SCORE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSNUMB_MINVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB ADD CONSTRAINT CC_SCORQSNUMB_MINVAL_NN CHECK (MIN_VAL IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSNUMB_MINSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB ADD CONSTRAINT CC_SCORQSNUMB_MINSIGN_NN CHECK (MIN_SIGN IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSNUMB_MAXVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB ADD CONSTRAINT CC_SCORQSNUMB_MAXVAL_NN CHECK (MAX_VAL IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSNUMB_MAXSIGN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB ADD CONSTRAINT CC_SCORQSNUMB_MAXSIGN_NN CHECK (MAX_SIGN IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




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




PROMPT *** Create  constraint SYS_C003177255 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB MODIFY (ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177254 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB MODIFY (QUESTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177253 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_NUMB MODIFY (SCORING_ID NOT NULL ENABLE)';
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





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_NUMB.sql =========*** E
PROMPT ===================================================================================== 
