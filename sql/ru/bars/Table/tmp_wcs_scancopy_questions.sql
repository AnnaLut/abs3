

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCANCOPY_QUESTIONS.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SCANCOPY_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SCANCOPY_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SCANCOPY_QUESTIONS 
   (	SCOPY_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	TYPE_ID VARCHAR2(100), 
	IS_REQUIRED NUMBER, 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_SCANCOPY_QUESTIONS ***
 exec bpa.alter_policies('TMP_WCS_SCANCOPY_QUESTIONS');


COMMENT ON TABLE BARS.TMP_WCS_SCANCOPY_QUESTIONS IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCANCOPY_QUESTIONS.SCOPY_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCANCOPY_QUESTIONS.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCANCOPY_QUESTIONS.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCANCOPY_QUESTIONS.IS_REQUIRED IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCANCOPY_QUESTIONS.ORD IS '';




PROMPT *** Create  constraint SYS_C003175534 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCANCOPY_QUESTIONS MODIFY (ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175533 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCANCOPY_QUESTIONS MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCANCOPY_QUESTIONS.sql =======
PROMPT ===================================================================================== 
