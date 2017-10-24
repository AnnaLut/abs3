

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SURVEY_GROUP_QUESTIONS.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SURVEY_GROUP_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SURVEY_GROUP_QUESTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SURVEY_GROUP_QUESTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SURVEY_GROUP_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS 
   (	SURVEY_ID VARCHAR2(100), 
	SGROUP_ID VARCHAR2(100), 
	RECTYPE_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	DNSHOW_IF VARCHAR2(4000), 
	IS_READONLY VARCHAR2(4000), 
	IS_REWRITABLE NUMBER, 
	IS_CHECKABLE NUMBER, 
	CHECK_PROC VARCHAR2(4000), 
	ORD NUMBER, 
	IS_REQUIRED VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SURVEY_GROUP_QUESTIONS ***
 exec bpa.alter_policies('WCS_SURVEY_GROUP_QUESTIONS');


COMMENT ON TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS IS '������� ����� �����-������';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.SURVEY_ID IS '������������� �����-������';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.SGROUP_ID IS '������������� ����� �����-������';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.RECTYPE_ID IS '��� ������ (������/������)';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.QUESTION_ID IS '������������� �������';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.DNSHOW_IF IS '������� �� �������� �� ���������� ������';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.IS_READONLY IS '������ ������ (null/1/true - OK, 0/false - NOT OK)';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.IS_REWRITABLE IS '����������� ����������';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.IS_CHECKABLE IS '����������� �� ����';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.CHECK_PROC IS '����� ��������';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.ORD IS '������� �����������';
COMMENT ON COLUMN BARS.WCS_SURVEY_GROUP_QUESTIONS.IS_REQUIRED IS '���������� ��� ���������� (null/1/true - OK, 0/false - NOT OK)';




PROMPT *** Create  constraint FK_QUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT FK_QUEST FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SGRPQUESTS_SURVEYGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT FK_SGRPQUESTS_SURVEYGROUPS FOREIGN KEY (SURVEY_ID, SGROUP_ID)
	  REFERENCES BARS.WCS_SURVEY_GROUPS (SURVEY_ID, ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SGRPQUESTS_RTID_SGRPRTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT FK_SGRPQUESTS_RTID_SGRPRTS_ID FOREIGN KEY (RECTYPE_ID)
	  REFERENCES BARS.WCS_SURVEY_GROUP_RECTYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGRPQUESTS_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT CC_SGRPQUESTS_ORD_NN CHECK (ORD IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGRPQUESTS_ISREWRITABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT CC_SGRPQUESTS_ISREWRITABLE CHECK (is_rewritable in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGRPQUESTS_ISCHECKABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT CC_SGRPQUESTS_ISCHECKABLE CHECK (is_checkable in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SGRPQUESTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT PK_SGRPQUESTS PRIMARY KEY (SURVEY_ID, SGROUP_ID, QUESTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177395 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS MODIFY (QUESTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177394 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS MODIFY (SGROUP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177393 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS MODIFY (SURVEY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SGRPQUESTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SGRPQUESTS ON BARS.WCS_SURVEY_GROUP_QUESTIONS (SURVEY_ID, SGROUP_ID, QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SURVEY_GROUP_QUESTIONS ***
grant SELECT                                                                 on WCS_SURVEY_GROUP_QUESTIONS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SURVEY_GROUP_QUESTIONS.sql =======
PROMPT ===================================================================================== 
