

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_GARANTEES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_GARANTEES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_GARANTEES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_GARANTEES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	NAME VARCHAR2(4000), 
	GRT_TABLE_ID VARCHAR2(4000), 
	SCOPY_ID VARCHAR2(4000), 
	SURVEY_ID VARCHAR2(4000), 
	COUNT_QID VARCHAR2(4000), 
	STATUS_QID VARCHAR2(4000), 
	WS_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_GARANTEES ***
 exec bpa.alter_policies('ERR$_WCS_GARANTEES');


COMMENT ON TABLE BARS.ERR$_WCS_GARANTEES IS 'DML Error Logging table for "WCS_GARANTEES"';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.NAME IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.GRT_TABLE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.SCOPY_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.SURVEY_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.COUNT_QID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.STATUS_QID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_GARANTEES.WS_ID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_GARANTEES.sql =========*** En
PROMPT ===================================================================================== 
