

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_QUESTION_MATRIX_PARAMS.sql ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_QUESTION_MATRIX_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_QUESTION_MATRIX_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_QUESTION_MATRIX_PARAMS 
   (	QUESTION_ID VARCHAR2(100), 
	AXIS_QID VARCHAR2(100), 
	ORD NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_QUESTION_MATRIX_PARAMS ***
 exec bpa.alter_policies('TMP_WCS_QUESTION_MATRIX_PARAMS');


COMMENT ON TABLE BARS.TMP_WCS_QUESTION_MATRIX_PARAMS IS '';
COMMENT ON COLUMN BARS.TMP_WCS_QUESTION_MATRIX_PARAMS.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_QUESTION_MATRIX_PARAMS.AXIS_QID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_QUESTION_MATRIX_PARAMS.ORD IS '';




PROMPT *** Create  constraint SYS_C003175530 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_QUESTION_MATRIX_PARAMS MODIFY (ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_QUESTION_MATRIX_PARAMS.sql ===
PROMPT ===================================================================================== 
