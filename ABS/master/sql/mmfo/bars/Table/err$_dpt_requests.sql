

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_REQUESTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_REQUESTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_REQUESTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_REQUESTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REQ_ID VARCHAR2(4000), 
	REQTYPE_ID VARCHAR2(4000), 
	REQ_BDATE VARCHAR2(4000), 
	REQ_CRDATE VARCHAR2(4000), 
	REQ_CRUSERID VARCHAR2(4000), 
	REQ_PRCDATE VARCHAR2(4000), 
	REQ_PRCUSERID VARCHAR2(4000), 
	REQ_STATE VARCHAR2(4000), 
	DPT_ID VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	BRANCH VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_REQUESTS ***
 exec bpa.alter_policies('ERR$_DPT_REQUESTS');


COMMENT ON TABLE BARS.ERR$_DPT_REQUESTS IS 'DML Error Logging table for "DPT_REQUESTS"';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.REQ_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.REQTYPE_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.REQ_BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.REQ_CRDATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.REQ_CRUSERID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.REQ_PRCDATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.REQ_PRCUSERID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.REQ_STATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.DPT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.KF IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_REQUESTS.BRANCH IS '';



PROMPT *** Create  grants  ERR$_DPT_REQUESTS ***
grant SELECT                                                                 on ERR$_DPT_REQUESTS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_REQUESTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_REQUESTS.sql =========*** End
PROMPT ===================================================================================== 
