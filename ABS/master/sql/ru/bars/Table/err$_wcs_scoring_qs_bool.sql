

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_SCORING_QS_BOOL.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_SCORING_QS_BOOL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_SCORING_QS_BOOL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_SCORING_QS_BOOL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SCORING_ID VARCHAR2(4000), 
	QUESTION_ID VARCHAR2(4000), 
	SCORE_IF_0 VARCHAR2(4000), 
	SCORE_IF_1 VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_SCORING_QS_BOOL ***
 exec bpa.alter_policies('ERR$_WCS_SCORING_QS_BOOL');


COMMENT ON TABLE BARS.ERR$_WCS_SCORING_QS_BOOL IS 'DML Error Logging table for "WCS_SCORING_QS_BOOL"';
COMMENT ON COLUMN BARS.ERR$_WCS_SCORING_QS_BOOL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCORING_QS_BOOL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCORING_QS_BOOL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCORING_QS_BOOL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCORING_QS_BOOL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCORING_QS_BOOL.SCORING_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCORING_QS_BOOL.QUESTION_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCORING_QS_BOOL.SCORE_IF_0 IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SCORING_QS_BOOL.SCORE_IF_1 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_SCORING_QS_BOOL.sql =========
PROMPT ===================================================================================== 
