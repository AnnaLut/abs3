

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_CREDIT_DEAL_VAR.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BPK_CREDIT_DEAL_VAR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BPK_CREDIT_DEAL_VAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BPK_CREDIT_DEAL_VAR 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	REPORT_DT VARCHAR2(4000), 
	DEAL_ND VARCHAR2(4000), 
	DEAL_SUM VARCHAR2(4000), 
	DEAL_RNK VARCHAR2(4000), 
	RATE VARCHAR2(4000), 
	MATUR_DT VARCHAR2(4000), 
	SS VARCHAR2(4000), 
	SN VARCHAR2(4000), 
	SP VARCHAR2(4000), 
	SPN VARCHAR2(4000), 
	CR9 VARCHAR2(4000), 
	CREATE_DT VARCHAR2(4000), 
	ADJ_FLG VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_BPK_CREDIT_DEAL_VAR ***
 exec bpa.alter_policies('ERR$_BPK_CREDIT_DEAL_VAR');


COMMENT ON TABLE BARS.ERR$_BPK_CREDIT_DEAL_VAR IS 'DML Error Logging table for "BPK_CREDIT_DEAL_VAR"';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.REPORT_DT IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.DEAL_ND IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.DEAL_SUM IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.DEAL_RNK IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.RATE IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.MATUR_DT IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.SS IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.SN IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.SP IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.SPN IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.CR9 IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.CREATE_DT IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.ADJ_FLG IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_CREDIT_DEAL_VAR.KF IS '';



PROMPT *** Create  grants  ERR$_BPK_CREDIT_DEAL_VAR ***
grant SELECT                                                                 on ERR$_BPK_CREDIT_DEAL_VAR to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_BPK_CREDIT_DEAL_VAR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_CREDIT_DEAL_VAR.sql =========
PROMPT ===================================================================================== 
