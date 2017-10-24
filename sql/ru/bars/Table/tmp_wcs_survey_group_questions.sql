

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SURVEY_GROUP_QUESTIONS.sql ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SURVEY_GROUP_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SURVEY_GROUP_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS 
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




PROMPT *** ALTER_POLICIES to TMP_WCS_SURVEY_GROUP_QUESTIONS ***
 exec bpa.alter_policies('TMP_WCS_SURVEY_GROUP_QUESTIONS');


COMMENT ON TABLE BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS.SURVEY_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS.SGROUP_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS.RECTYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS.DNSHOW_IF IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS.IS_READONLY IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS.IS_REWRITABLE IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS.IS_CHECKABLE IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS.CHECK_PROC IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS.ORD IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS.IS_REQUIRED IS '';




PROMPT *** Create  constraint SYS_C003175591 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SURVEY_GROUP_QUESTIONS MODIFY (ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SURVEY_GROUP_QUESTIONS.sql ===
PROMPT ===================================================================================== 
