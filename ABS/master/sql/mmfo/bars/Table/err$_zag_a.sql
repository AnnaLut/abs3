

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAG_A.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAG_A ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAG_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAG_A 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	FN VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	REF VARCHAR2(4000), 
	KV VARCHAR2(4000), 
	N VARCHAR2(4000), 
	SDE VARCHAR2(4000), 
	SKR VARCHAR2(4000), 
	DATK VARCHAR2(4000), 
	DAT_2 VARCHAR2(4000), 
	OTM VARCHAR2(4000), 
	SIGN RAW(2000), 
	SIGN_KEY VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAG_A ***
 exec bpa.alter_policies('ERR$_ZAG_A');


COMMENT ON TABLE BARS.ERR$_ZAG_A IS 'DML Error Logging table for "ZAG_A"';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.FN IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.REF IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.KV IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.N IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.SDE IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.SKR IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.DATK IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.DAT_2 IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.SIGN IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.SIGN_KEY IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_A.KF IS '';



PROMPT *** Create  grants  ERR$_ZAG_A ***
grant SELECT                                                                 on ERR$_ZAG_A      to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ZAG_A      to BARS_DM;
grant SELECT                                                                 on ERR$_ZAG_A      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAG_A.sql =========*** End *** ==
PROMPT ===================================================================================== 
