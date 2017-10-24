

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCORING_QS_MATRIX.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_SCORING_QS_MATRIX ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_SCORING_QS_MATRIX ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_SCORING_QS_MATRIX 
   (	SCORING_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	SCORE NUMBER, 
	AXIS0_ORD NUMBER, 
	AXIS1_ORD NUMBER, 
	AXIS2_ORD NUMBER, 
	AXIS3_ORD NUMBER, 
	AXIS4_ORD NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_SCORING_QS_MATRIX ***
 exec bpa.alter_policies('TMP_WCS_SCORING_QS_MATRIX');


COMMENT ON TABLE BARS.TMP_WCS_SCORING_QS_MATRIX IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_MATRIX.SCORING_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_MATRIX.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_MATRIX.SCORE IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_MATRIX.AXIS0_ORD IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_MATRIX.AXIS1_ORD IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_MATRIX.AXIS2_ORD IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_MATRIX.AXIS3_ORD IS '';
COMMENT ON COLUMN BARS.TMP_WCS_SCORING_QS_MATRIX.AXIS4_ORD IS '';




PROMPT *** Create  constraint SYS_C003175555 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_MATRIX MODIFY (AXIS1_ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175554 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_MATRIX MODIFY (AXIS0_ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175553 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_MATRIX MODIFY (SCORE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175552 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_MATRIX MODIFY (QUESTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175551 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_SCORING_QS_MATRIX MODIFY (SCORING_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_SCORING_QS_MATRIX.sql ========
PROMPT ===================================================================================== 
