

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAG_MC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAG_MC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAG_MC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAG_MC 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FN VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	N VARCHAR2(4000), 
	SIGN_KEY VARCHAR2(4000), 
	SIGN RAW(2000), 
	FN2 VARCHAR2(4000), 
	DAT2 VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	DATK VARCHAR2(4000), 
	SAB VARCHAR2(4000), 
	COUNTER VARCHAR2(4000), 
	DAT_FM VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAG_MC ***
 exec bpa.alter_policies('ERR$_ZAG_MC');


COMMENT ON TABLE BARS.ERR$_ZAG_MC IS 'DML Error Logging table for "ZAG_MC"';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.SIGN_KEY IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.SIGN IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.FN2 IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.DAT2 IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.DATK IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.SAB IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.COUNTER IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.DAT_FM IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.KF IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.FN IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_MC.N IS '';



PROMPT *** Create  grants  ERR$_ZAG_MC ***
grant SELECT                                                                 on ERR$_ZAG_MC     to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ZAG_MC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAG_MC.sql =========*** End *** =
PROMPT ===================================================================================== 
