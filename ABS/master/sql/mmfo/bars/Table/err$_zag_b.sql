

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_ZAG_B.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_ZAG_B ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_ZAG_B ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_ZAG_B 
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
	SSP_SIGN_KEY VARCHAR2(4000), 
	SSP_SIGN RAW(2000), 
	KF VARCHAR2(4000), 
	K_ER VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_ZAG_B ***
 exec bpa.alter_policies('ERR$_ZAG_B');


COMMENT ON TABLE BARS.ERR$_ZAG_B IS 'DML Error Logging table for "ZAG_B"';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.SSP_SIGN IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.KF IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.K_ER IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.FN IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.REF IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.KV IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.N IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.SDE IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.SKR IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.DATK IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.DAT_2 IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.OTM IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.SIGN IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.SIGN_KEY IS '';
COMMENT ON COLUMN BARS.ERR$_ZAG_B.SSP_SIGN_KEY IS '';



PROMPT *** Create  grants  ERR$_ZAG_B ***
grant SELECT                                                                 on ERR$_ZAG_B      to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_ZAG_B      to BARS_DM;
grant SELECT                                                                 on ERR$_ZAG_B      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_ZAG_B.sql =========*** End *** ==
PROMPT ===================================================================================== 
