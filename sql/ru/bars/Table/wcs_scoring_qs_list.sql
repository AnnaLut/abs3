

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_LIST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SCORING_QS_LIST ***


BEGIN 
        execute immediate  
          'begin  
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
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SCORING_QS_LIST ***
 exec bpa.alter_policies('WCS_SCORING_QS_LIST');


COMMENT ON TABLE BARS.WCS_SCORING_QS_LIST IS '������ ����� �������� (��������� �� �������� ���� LIST)';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_LIST.SCORING_ID IS '������������� ����� ��������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_LIST.QUESTION_ID IS '������������� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_LIST.ORD IS '����� �������';
COMMENT ON COLUMN BARS.WCS_SCORING_QS_LIST.SCORE IS '�����';




PROMPT *** Create  constraint FK_SCORQSLST_SCORQUESTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_LIST ADD CONSTRAINT FK_SCORQSLST_SCORQUESTS FOREIGN KEY (SCORING_ID, QUESTION_ID)
	  REFERENCES BARS.WCS_SCORING_QUESTIONS (SCORING_ID, QUESTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SCORQSLST_SCORE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_LIST ADD CONSTRAINT CC_SCORQSLST_SCORE_NN CHECK (SCORE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SCORQSLST ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_LIST ADD CONSTRAINT PK_SCORQSLST PRIMARY KEY (SCORING_ID, QUESTION_ID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177208 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_LIST MODIFY (ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177207 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_LIST MODIFY (QUESTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177206 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORING_QS_LIST MODIFY (SCORING_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCORQSLST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCORQSLST ON BARS.WCS_SCORING_QS_LIST (SCORING_ID, QUESTION_ID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SCORING_QS_LIST.sql =========*** E
PROMPT ===================================================================================== 
