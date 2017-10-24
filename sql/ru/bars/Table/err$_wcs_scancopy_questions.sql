

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_SCANCOPY_QUESTIONS.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_SCANCOPY_QUESTIONS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_SCANCOPY_QUESTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_SCANCOPY_QUESTIONS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SCOPY_ID VARCHAR2(4000), 
	QUESTION_ID VARCHAR2(4000), 
	TYPE_ID VARCHAR2(4000), 
	IS_REQUIRED VARCHAR2(4000), 
	ORD VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_SCANCOPY_QUESTIONS ***
 exec bpa.alter_policies('ERR$_WCS_SCANCOPY_QUESTIONS');


COMMENT ON TABLE BARS.ERR$_WCS_SCANCOPY_QUESTIONS IS 'DML Error Logging table for "WCS_SCANCOPY_QUESTIONS"';
COMMENT ON COLUMN BARS.ERR$_WCS_SCANCOPY_QUESTIONS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCANCOPY_QUESTIONS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCANCOPY_QUESTIONS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCANCOPY_QUESTIONS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCANCOPY_QUESTIONS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCANCOPY_QUESTIONS.SCOPY_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCANCOPY_QUESTIONS.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCANCOPY_QUESTIONS.TYPE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCANCOPY_QUESTIONS.IS_REQUIRED IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCANCOPY_QUESTIONS.ORD IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_SCANCOPY_QUESTIONS.sql ======
PROMPT ===================================================================================== 
