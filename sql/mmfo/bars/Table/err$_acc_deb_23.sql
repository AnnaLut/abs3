

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_DEB_23.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ACC_DEB_23 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ACC_DEB_23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ACC_DEB_23 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	FIN VARCHAR2(4000), 
	OBS VARCHAR2(4000), 
	KAT VARCHAR2(4000), 
	K VARCHAR2(4000), 
	SERR VARCHAR2(4000), 
	D_P VARCHAR2(4000), 
	D_V VARCHAR2(4000), 
	KOL_P VARCHAR2(4000), 
	KOL_VZ VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	DEB VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ACC_DEB_23 ***
 exec bpa.alter_policies('ERR$_ACC_DEB_23');


COMMENT ON TABLE BARS.ERR$_ACC_DEB_23 IS 'DML Error Logging table for "ACC_DEB_23"';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.DEB IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.FIN IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.OBS IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.KAT IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.K IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.SERR IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.D_P IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.D_V IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.KOL_P IS '';
COMMENT ON COLUMN BARS.ERR$_ACC_DEB_23.KOL_VZ IS '';



PROMPT *** Create  grants  ERR$_ACC_DEB_23 ***
grant SELECT                                                                 on ERR$_ACC_DEB_23 to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ACC_DEB_23 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ACC_DEB_23.sql =========*** End *
PROMPT ===================================================================================== 
