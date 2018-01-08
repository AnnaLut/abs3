

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_JOBS_JRNL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_JOBS_JRNL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_JOBS_JRNL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_JOBS_JRNL 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RUN_ID VARCHAR2(4000), 
	JOB_ID VARCHAR2(4000), 
	START_DATE VARCHAR2(4000), 
	FINISH_DATE VARCHAR2(4000), 
	BANK_DATE VARCHAR2(4000), 
	USER_ID VARCHAR2(4000), 
	STATUS VARCHAR2(4000), 
	ERRMSG VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	DELETED VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_JOBS_JRNL ***
 exec bpa.alter_policies('ERR$_DPT_JOBS_JRNL');


COMMENT ON TABLE BARS.ERR$_DPT_JOBS_JRNL IS 'DML Error Logging table for "DPT_JOBS_JRNL"';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.RUN_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.JOB_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.START_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.FINISH_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.BANK_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.USER_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.ERRMSG IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.DELETED IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_JRNL.KF IS '';



PROMPT *** Create  grants  ERR$_DPT_JOBS_JRNL ***
grant SELECT                                                                 on ERR$_DPT_JOBS_JRNL to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_JOBS_JRNL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_JOBS_JRNL.sql =========*** En
PROMPT ===================================================================================== 
