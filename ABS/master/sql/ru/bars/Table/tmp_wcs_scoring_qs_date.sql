

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCORING_QS_DATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SCORING_QS_DATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SCORING_QS_DATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SCORING_QS_DATE 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	ORD NUMBER, 
	MIN_VAL DATE, 
	MIN_SIGN VARCHAR2(100), 
	MAX_VAL DATE, 
	MAX_SIGN VARCHAR2(100), 
	SCORE NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_SCORING_QS_DATE ***
 exec bpa.alter_policies('TMP_WCS_SCORING_QS_DATE');


COMMENT ON TABLE BARS.TMP_WCS_SCORING_QS_DATE IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DATE.SCORING_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DATE.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DATE.ORD IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DATE.MIN_VAL IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DATE.MIN_SIGN IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DATE.MAX_VAL IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DATE.MAX_SIGN IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_DATE.SCORE IS '';




PROMPT *** Create  constraint SYS_C003175544 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_DATE MODIFY (SCORE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175543 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_DATE MODIFY (MAX_SIGN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175542 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_DATE MODIFY (MAX_VAL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175541 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_DATE MODIFY (MIN_SIGN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175540 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_DATE MODIFY (MIN_VAL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCORING_QS_DATE.sql =========*
PROMPT ===================================================================================== 
