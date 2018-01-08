

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_PRVN_FIN_DEB.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_PRVN_FIN_DEB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_PRVN_FIN_DEB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_PRVN_FIN_DEB 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC_SS VARCHAR2(4000), 
	ACC_SP VARCHAR2(4000), 
	EFFECTDATE VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_PRVN_FIN_DEB ***
 exec bpa.alter_policies('ERR$_PRVN_FIN_DEB');


COMMENT ON TABLE BARS.ERR$_PRVN_FIN_DEB IS 'DML Error Logging table for "PRVN_FIN_DEB"';
COMMENT ON COLUMN BARS.ERR$_PRVN_FIN_DEB.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FIN_DEB.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FIN_DEB.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FIN_DEB.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FIN_DEB.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FIN_DEB.ACC_SS IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FIN_DEB.ACC_SP IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FIN_DEB.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.ERR$_PRVN_FIN_DEB.KF IS '';



PROMPT *** Create  grants  ERR$_PRVN_FIN_DEB ***
grant SELECT                                                                 on ERR$_PRVN_FIN_DEB to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_PRVN_FIN_DEB to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_PRVN_FIN_DEB.sql =========*** End
PROMPT ===================================================================================== 
