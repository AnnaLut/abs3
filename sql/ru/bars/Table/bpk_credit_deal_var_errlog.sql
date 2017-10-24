

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_CREDIT_DEAL_VAR_ERRLOG.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_CREDIT_DEAL_VAR_ERRLOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_CREDIT_DEAL_VAR_ERRLOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_CREDIT_DEAL_VAR_ERRLOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_CREDIT_DEAL_VAR_ERRLOG 
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
	ADJ_FLG VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_CREDIT_DEAL_VAR_ERRLOG ***
 exec bpa.alter_policies('BPK_CREDIT_DEAL_VAR_ERRLOG');


COMMENT ON TABLE BARS.BPK_CREDIT_DEAL_VAR_ERRLOG IS 'DML Error Logging table for "BPK_CREDIT_DEAL_VAR"';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.REPORT_DT IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.DEAL_ND IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.DEAL_SUM IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.DEAL_RNK IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.RATE IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.MATUR_DT IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.SS IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.SN IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.SP IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.SPN IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.CR9 IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.CREATE_DT IS '';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR_ERRLOG.ADJ_FLG IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_CREDIT_DEAL_VAR_ERRLOG.sql =======
PROMPT ===================================================================================== 
