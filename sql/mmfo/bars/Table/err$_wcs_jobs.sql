

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_JOBS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_WCS_JOBS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_WCS_JOBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_WCS_JOBS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	BID_ID VARCHAR2(4000), 
	IQUERY_ID VARCHAR2(4000), 
	STATUS_ID VARCHAR2(4000), 
	ERR_MSG VARCHAR2(4000), 
	RS_ID VARCHAR2(4000), 
	RS_IQS_TCNT VARCHAR2(4000), 
	RS_STATE_ID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_WCS_JOBS ***
 exec bpa.alter_policies('ERR$_WCS_JOBS');


COMMENT ON TABLE BARS.ERR$_WCS_JOBS IS 'DML Error Logging table for "WCS_JOBS"';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.BID_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.IQUERY_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.STATUS_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.ERR_MSG IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.RS_ID IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.RS_IQS_TCNT IS '';
COMMENT ON COLUMN BARS.ERR$_WCS_JOBS.RS_STATE_ID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_WCS_JOBS.sql =========*** End ***
PROMPT ===================================================================================== 
