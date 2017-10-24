

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCORING_QS_DECIMAL.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SCORING_QS_DECIMAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SCORING_QS_DECIMAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SCORING_QS_DECIMAL 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	ORD NUMBER, 
	MIN_VAL NUMBER, 
	MIN_SIGN VARCHAR2(100), 
	MAX_VAL NUMBER, 
	MAX_SIGN VARCHAR2(100), 
	SCORE NUMBER, 
	SCORE_MAX NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_SCORING_QS_DECIMAL ***
 exec bpa.alter_policies('TMP_WCS_SCORING_QS_DECIMAL');


COMMENT ON TABLE BARS.TMP_WCS_SCORING_QS_DECIMAL IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DECIMAL.SCORING_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DECIMAL.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DECIMAL.ORD IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DECIMAL.MIN_VAL IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DECIMAL.MIN_SIGN IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DECIMAL.MAX_VAL IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DECIMAL.MAX_SIGN IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DECIMAL.SCORE IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DECIMAL.SCORE_MAX IS '';




PROMPT *** Create  constraint SYS_C003175549 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_DECIMAL MODIFY (SCORE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175548 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_DECIMAL MODIFY (MAX_SIGN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175547 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_DECIMAL MODIFY (MAX_VAL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175546 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_DECIMAL MODIFY (MIN_SIGN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175545 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_DECIMAL MODIFY (MIN_VAL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCORING_QS_DECIMAL.sql =======
PROMPT ===================================================================================== 
