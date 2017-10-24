

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_AUTHORIZATION_QUESTIONS.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_AUTHORIZATION_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_AUTHORIZATION_QUESTIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_AUTHORIZATION_QUESTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_AUTHORIZATION_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_AUTHORIZATION_QUESTIONS 
   (	AUTH_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	SCOPY_QID VARCHAR2(100), 
	IS_REQUIRED NUMBER DEFAULT 1, 
	IS_CHECKABLE NUMBER DEFAULT 0, 
	CHECK_PROC VARCHAR2(4000), 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_AUTHORIZATION_QUESTIONS ***
 exec bpa.alter_policies('WCS_AUTHORIZATION_QUESTIONS');


COMMENT ON TABLE BARS.WCS_AUTHORIZATION_QUESTIONS IS '������� ����� �����������';
COMMENT ON COLUMN BARS.WCS_AUTHORIZATION_QUESTIONS.AUTH_ID IS '������������� ����� �����������';
COMMENT ON COLUMN BARS.WCS_AUTHORIZATION_QUESTIONS.QUESTION_ID IS '������������� �������';
COMMENT ON COLUMN BARS.WCS_AUTHORIZATION_QUESTIONS.SCOPY_QID IS '������������� ������� ������� ���������';
COMMENT ON COLUMN BARS.WCS_AUTHORIZATION_QUESTIONS.IS_REQUIRED IS '���������� �� ��� ����������';
COMMENT ON COLUMN BARS.WCS_AUTHORIZATION_QUESTIONS.IS_CHECKABLE IS '����������� �� ����';
COMMENT ON COLUMN BARS.WCS_AUTHORIZATION_QUESTIONS.CHECK_PROC IS '����� ��������';
COMMENT ON COLUMN BARS.WCS_AUTHORIZATION_QUESTIONS.ORD IS '������� �����������';




PROMPT *** Create  constraint FK_AUTHQS_AID_AUTHS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_AUTHORIZATION_QUESTIONS ADD CONSTRAINT FK_AUTHQS_AID_AUTHS_ID FOREIGN KEY (AUTH_ID)
	  REFERENCES BARS.WCS_AUTHORIZATIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_AUTHORIZATIONQUESTIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_AUTHORIZATION_QUESTIONS ADD CONSTRAINT PK_AUTHORIZATIONQUESTIONS PRIMARY KEY (AUTH_ID, QUESTION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AUTHQS_ISCHECKABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_AUTHORIZATION_QUESTIONS ADD CONSTRAINT CC_AUTHQS_ISCHECKABLE CHECK (is_checkable in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AUTHQS_REQUIRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_AUTHORIZATION_QUESTIONS ADD CONSTRAINT CC_AUTHQS_REQUIRED CHECK (is_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AUTHQS_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_AUTHORIZATION_QUESTIONS MODIFY (ORD CONSTRAINT CC_AUTHQS_ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_AUTHORIZATIONQUESTIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_AUTHORIZATIONQUESTIONS ON BARS.WCS_AUTHORIZATION_QUESTIONS (AUTH_ID, QUESTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_AUTHORIZATION_QUESTIONS.sql ======
PROMPT ===================================================================================== 
