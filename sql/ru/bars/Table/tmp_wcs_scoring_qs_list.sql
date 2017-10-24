

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCORING_QS_LIST.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SCORING_QS_LIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SCORING_QS_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SCORING_QS_LIST 
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




PROMPT *** ALTER_POLICIES to TMP_WCS_SCORING_QS_LIST ***
 exec bpa.alter_policies('TMP_WCS_SCORING_QS_LIST');


COMMENT ON TABLE BARS.TMP_WCS_SCORING_QS_LIST IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_LIST.SCORING_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_LIST.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_LIST.ORD IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_LIST.SCORE IS '';




PROMPT *** Create  constraint SYS_C003175550 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_LIST MODIFY (SCORE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCORING_QS_LIST.sql =========*
PROMPT ===================================================================================== 
