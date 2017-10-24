

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_SURVEY_GROUPS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_SURVEY_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_SURVEY_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_SURVEY_GROUPS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SURVEY_ID VARCHAR2(4000), 
	ID VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	DNSHOW_IF VARCHAR2(4000), 
	ORD VARCHAR2(4000), 
	RESULT_QID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_SURVEY_GROUPS ***
 exec bpa.alter_policies('ERR$_WCS_SURVEY_GROUPS');


COMMENT ON TABLE BARS.ERR$_WCS_SURVEY_GROUPS IS 'DML Error Logging table for "WCS_SURVEY_GROUPS"';
COMMENT ON COLUMN BARS.ERR$_WCS_SURVEY_GROUPS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SURVEY_GROUPS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SURVEY_GROUPS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SURVEY_GROUPS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SURVEY_GROUPS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SURVEY_GROUPS.SURVEY_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SURVEY_GROUPS.ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SURVEY_GROUPS.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SURVEY_GROUPS.DNSHOW_IF IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SURVEY_GROUPS.ORD IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_SURVEY_GROUPS.RESULT_QID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_SURVEY_GROUPS.sql =========**
PROMPT ===================================================================================== 
