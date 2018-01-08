

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_DPU_ACCOUNTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_DPU_ACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_DPU_ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_DPU_ACCOUNTS 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	KF VARCHAR2(4000), 
	DPUID VARCHAR2(4000), 
	ACCID VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_DPU_ACCOUNTS ***
 exec bpa.alter_policies('ERR$_DPU_ACCOUNTS');


COMMENT ON TABLE BARS.ERR$_DPU_ACCOUNTS IS 'DML Error Logging table for "DPU_ACCOUNTS"';
COMMENT ON COLUMN BARS.ERR$_DPU_ACCOUNTS.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_ACCOUNTS.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_ACCOUNTS.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_ACCOUNTS.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_ACCOUNTS.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_ACCOUNTS.KF IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_ACCOUNTS.DPUID IS '';
COMMENT ON COLUMN BARS.ERR$_DPU_ACCOUNTS.ACCID IS '';



PROMPT *** Create  grants  ERR$_DPU_ACCOUNTS ***
grant SELECT                                                                 on ERR$_DPU_ACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_DPU_ACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_DPU_ACCOUNTS.sql =========*** End
PROMPT ===================================================================================== 
