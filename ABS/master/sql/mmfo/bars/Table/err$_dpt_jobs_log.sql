

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_JOBS_LOG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_JOBS_LOG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_JOBS_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_JOBS_LOG 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REC_ID VARCHAR2(4000), 
	RUN_ID VARCHAR2(4000), 
	JOB_ID VARCHAR2(4000), 
	DPT_ID VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	DPT_SUM VARCHAR2(4000), 
	INT_SUM VARCHAR2(4000), 
	STATUS VARCHAR2(4000), 
	ERRMSG VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	CONTRACT_ID VARCHAR2(4000), 
	DEAL_NUM VARCHAR2(4000), 
	RATE_VAL VARCHAR2(4000), 
	RATE_DAT VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_JOBS_LOG ***
 exec bpa.alter_policies('ERR$_DPT_JOBS_LOG');


COMMENT ON TABLE BARS.ERR$_DPT_JOBS_LOG IS 'DML Error Logging table for "DPT_JOBS_LOG"';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.REC_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.RUN_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.JOB_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.DPT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.REF IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.KV IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.DPT_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.INT_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.STATUS IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.ERRMSG IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.CONTRACT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.DEAL_NUM IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.RATE_VAL IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.RATE_DAT IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_JOBS_LOG.KF IS '';



PROMPT *** Create  grants  ERR$_DPT_JOBS_LOG ***
grant SELECT                                                                 on ERR$_DPT_JOBS_LOG to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPT_JOBS_LOG to BARS_DM;
grant SELECT                                                                 on ERR$_DPT_JOBS_LOG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_JOBS_LOG.sql =========*** End
PROMPT ===================================================================================== 
