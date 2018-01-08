

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_PAYMENTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPT_PAYMENTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPT_PAYMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPT_PAYMENTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	DPT_ID VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	RNK VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPT_PAYMENTS ***
 exec bpa.alter_policies('ERR$_DPT_PAYMENTS');


COMMENT ON TABLE BARS.ERR$_DPT_PAYMENTS IS 'DML Error Logging table for "DPT_PAYMENTS"';
COMMENT ON COLUMN BARS.ERR$_DPT_PAYMENTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_PAYMENTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_PAYMENTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_PAYMENTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_PAYMENTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_PAYMENTS.DPT_ID IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_PAYMENTS.REF IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_PAYMENTS.KF IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_PAYMENTS.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_DPT_PAYMENTS.RNK IS '';



PROMPT *** Create  grants  ERR$_DPT_PAYMENTS ***
grant SELECT                                                                 on ERR$_DPT_PAYMENTS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPT_PAYMENTS.sql =========*** End
PROMPT ===================================================================================== 
