

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SPECPARAM_INT_UPDATE.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SPECPARAM_INT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SPECPARAM_INT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SPECPARAM_INT_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ACC VARCHAR2(4000), 
	P080 VARCHAR2(4000), 
	OB22 VARCHAR2(4000), 
	OB88 VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	R020_FA VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	USER_NAME VARCHAR2(4000), 
	IDUPD VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SPECPARAM_INT_UPDATE ***
 exec bpa.alter_policies('ERR$_SPECPARAM_INT_UPDATE');


COMMENT ON TABLE BARS.ERR$_SPECPARAM_INT_UPDATE IS 'DML Error Logging table for "SPECPARAM_INT_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.P080 IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.OB22 IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.OB88 IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.R020_FA IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.USER_NAME IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_SPECPARAM_INT_UPDATE.KF IS '';



PROMPT *** Create  grants  ERR$_SPECPARAM_INT_UPDATE ***
grant SELECT                                                                 on ERR$_SPECPARAM_INT_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SPECPARAM_INT_UPDATE to BARS_DM;
grant SELECT                                                                 on ERR$_SPECPARAM_INT_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SPECPARAM_INT_UPDATE.sql ========
PROMPT ===================================================================================== 
