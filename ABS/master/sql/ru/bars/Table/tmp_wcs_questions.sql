

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_QUESTIONS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_QUESTIONS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	IS_CALCABLE NUMBER, 
	CALC_PROC VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_QUESTIONS ***
 exec bpa.alter_policies('TMP_WCS_QUESTIONS');


COMMENT ON TABLE BARS.TMP_WCS_QUESTIONS IS '';
COMMENT ON COLUMN BARS.TMP_WCS_QUESTIONS.ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_QUESTIONS.NAME IS '';
COMMENT ON COLUMN BARS.TMP_WCS_QUESTIONS.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_QUESTIONS.IS_CALCABLE IS '';
COMMENT ON COLUMN BARS.TMP_WCS_QUESTIONS.CALC_PROC IS '';




PROMPT *** Create  constraint SYS_C003175528 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_QUESTIONS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_QUESTIONS.sql =========*** End
PROMPT ===================================================================================== 
