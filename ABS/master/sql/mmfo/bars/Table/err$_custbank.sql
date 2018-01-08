

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTBANK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_CUSTBANK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_CUSTBANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_CUSTBANK 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	RNK VARCHAR2(4000), 
	MFO VARCHAR2(4000), 
	ALT_BIC VARCHAR2(4000), 
	BIC VARCHAR2(4000), 
	RATING VARCHAR2(4000), 
	KOD_B VARCHAR2(4000), 
	DAT_ND VARCHAR2(4000), 
	RUK VARCHAR2(4000), 
	TELR VARCHAR2(4000), 
	BUH VARCHAR2(4000), 
	TELB VARCHAR2(4000), 
	NUM_ND VARCHAR2(4000), 
	BKI VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_CUSTBANK ***
 exec bpa.alter_policies('ERR$_CUSTBANK');


COMMENT ON TABLE BARS.ERR$_CUSTBANK IS 'DML Error Logging table for "CUSTBANK"';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.MFO IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.ALT_BIC IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.BIC IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.RATING IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.KOD_B IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.DAT_ND IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.RUK IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.TELR IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.BUH IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.TELB IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.NUM_ND IS '';
COMMENT ON COLUMN BARS.ERR$_CUSTBANK.BKI IS '';



PROMPT *** Create  grants  ERR$_CUSTBANK ***
grant SELECT                                                                 on ERR$_CUSTBANK   to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_CUSTBANK   to BARS_DM;
grant SELECT                                                                 on ERR$_CUSTBANK   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_CUSTBANK.sql =========*** End ***
PROMPT ===================================================================================== 
