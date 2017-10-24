

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_PAYMENT_QUESTIONS.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_PAYMENT_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_PAYMENT_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_PAYMENT_QUESTIONS 
   (	TYPE_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_PAYMENT_QUESTIONS ***
 exec bpa.alter_policies('TMP_WCS_PAYMENT_QUESTIONS');


COMMENT ON TABLE BARS.TMP_WCS_PAYMENT_QUESTIONS IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PAYMENT_QUESTIONS.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PAYMENT_QUESTIONS.QUESTION_ID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_PAYMENT_QUESTIONS.sql ========
PROMPT ===================================================================================== 
