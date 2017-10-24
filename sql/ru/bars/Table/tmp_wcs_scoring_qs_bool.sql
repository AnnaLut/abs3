

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCORING_QS_BOOL.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SCORING_QS_BOOL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SCORING_QS_BOOL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SCORING_QS_BOOL 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	SCORE_IF_0 NUMBER, 
	SCORE_IF_1 NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_SCORING_QS_BOOL ***
 exec bpa.alter_policies('TMP_WCS_SCORING_QS_BOOL');


COMMENT ON TABLE BARS.TMP_WCS_SCORING_QS_BOOL IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_BOOL.SCORING_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_BOOL.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_BOOL.SCORE_IF_0 IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_BOOL.SCORE_IF_1 IS '';




PROMPT *** Create  constraint SYS_C003175539 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_BOOL MODIFY (SCORE_IF_1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175538 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_BOOL MODIFY (SCORE_IF_0 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCORING_QS_BOOL.sql =========*
PROMPT ===================================================================================== 
