

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ACCOUNTSW_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ACCOUNTSW_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ACCOUNTSW_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ACCOUNTSW_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IDUPD VARCHAR2(4000), 
	CHGACTION VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	ACC VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	VALUE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ACCOUNTSW_UPDATE ***
 exec bpa.alter_policies('ERR$_ACCOUNTSW_UPDATE');


COMMENT ON TABLE BARS.ERR$_ACCOUNTSW_UPDATE IS 'DML Error Logging table for "ACCOUNTSW_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_ACCOUNTSW_UPDATE.CHGACTION IS '';



PROMPT *** Create  grants  ERR$_ACCOUNTSW_UPDATE ***
grant SELECT                                                                 on ERR$_ACCOUNTSW_UPDATE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ACCOUNTSW_UPDATE.sql =========***
PROMPT ===================================================================================== 
