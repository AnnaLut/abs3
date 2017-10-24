

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SURVEY_GROUPS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SURVEY_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SURVEY_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SURVEY_GROUPS 
   (	SURVEY_ID VARCHAR2(100), 
	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	DNSHOW_IF VARCHAR2(4000), 
	ORD NUMBER, 
	RESULT_QID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_SURVEY_GROUPS ***
 exec bpa.alter_policies('TMP_WCS_SURVEY_GROUPS');


COMMENT ON TABLE BARS.TMP_WCS_SURVEY_GROUPS IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUPS.SURVEY_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUPS.ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUPS.NAME IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUPS.DNSHOW_IF IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUPS.ORD IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SURVEY_GROUPS.RESULT_QID IS '';




PROMPT *** Create  constraint SYS_C003175590 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SURVEY_GROUPS MODIFY (ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175589 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SURVEY_GROUPS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SURVEY_GROUPS.sql =========***
PROMPT ===================================================================================== 
