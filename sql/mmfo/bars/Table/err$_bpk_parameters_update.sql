

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_PARAMETERS_UPDATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_BPK_PARAMETERS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_BPK_PARAMETERS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_BPK_PARAMETERS_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	IDUPD VARCHAR2(4000), 
	CHGACTION VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	GLOBAL_BDATE VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	ND VARCHAR2(4000), 
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




PROMPT *** ALTER_POLICIES to ERR$_BPK_PARAMETERS_UPDATE ***
 exec bpa.alter_policies('ERR$_BPK_PARAMETERS_UPDATE');


COMMENT ON TABLE BARS.ERR$_BPK_PARAMETERS_UPDATE IS 'DML Error Logging table for "BPK_PARAMETERS_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.GLOBAL_BDATE IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.VALUE IS '';
COMMENT ON COLUMN BARS.ERR$_BPK_PARAMETERS_UPDATE.KF IS '';



PROMPT *** Create  grants  ERR$_BPK_PARAMETERS_UPDATE ***
grant SELECT                                                                 on ERR$_BPK_PARAMETERS_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_BPK_PARAMETERS_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_BPK_PARAMETERS_UPDATE.sql =======
PROMPT ===================================================================================== 
