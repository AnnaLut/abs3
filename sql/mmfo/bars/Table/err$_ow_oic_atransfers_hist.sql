

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OW_OIC_ATRANSFERS_HIST.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OW_OIC_ATRANSFERS_HIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OW_OIC_ATRANSFERS_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OW_OIC_ATRANSFERS_HIST 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ID VARCHAR2(4000), 
	IDN VARCHAR2(4000), 
	ANL_SYNTHCODE VARCHAR2(4000), 
	ANL_TRNDESCR VARCHAR2(4000), 
	ANL_ANALYTICREFN VARCHAR2(4000), 
	CREDIT_ANLACCOUNT VARCHAR2(4000), 
	CREDIT_AMOUNT VARCHAR2(4000), 
	CREDIT_CURRENCY VARCHAR2(4000), 
	DEBIT_ANLACCOUNT VARCHAR2(4000), 
	DEBIT_AMOUNT VARCHAR2(4000), 
	DEBIT_CURRENCY VARCHAR2(4000), 
	ANL_POSTINGDATE VARCHAR2(4000), 
	DOC_DRN VARCHAR2(4000), 
	DOC_LOCALDATE VARCHAR2(4000), 
	DOC_DESCR VARCHAR2(4000), 
	DOC_AMOUNT VARCHAR2(4000), 
	DOC_CURRENCY VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	DOC_ORN VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OW_OIC_ATRANSFERS_HIST ***
 exec bpa.alter_policies('ERR$_OW_OIC_ATRANSFERS_HIST');


COMMENT ON TABLE BARS.ERR$_OW_OIC_ATRANSFERS_HIST IS 'DML Error Logging table for "OW_OIC_ATRANSFERS_HIST"';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.ID IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.IDN IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.ANL_SYNTHCODE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.ANL_TRNDESCR IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.ANL_ANALYTICREFN IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.CREDIT_ANLACCOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.CREDIT_AMOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.CREDIT_CURRENCY IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.DEBIT_ANLACCOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.DEBIT_AMOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.DEBIT_CURRENCY IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.ANL_POSTINGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.DOC_DRN IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.DOC_LOCALDATE IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.DOC_DESCR IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.DOC_AMOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.DOC_CURRENCY IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.REF IS '';
COMMENT ON COLUMN BARS.ERR$_OW_OIC_ATRANSFERS_HIST.DOC_ORN IS '';



PROMPT *** Create  grants  ERR$_OW_OIC_ATRANSFERS_HIST ***
grant SELECT                                                                 on ERR$_OW_OIC_ATRANSFERS_HIST to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_OW_OIC_ATRANSFERS_HIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OW_OIC_ATRANSFERS_HIST.sql ======
PROMPT ===================================================================================== 
