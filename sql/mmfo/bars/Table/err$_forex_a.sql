

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FOREX_A.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FOREX_A ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FOREX_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FOREX_A 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	NTIK VARCHAR2(4000), 
	DAT VARCHAR2(4000), 
	RNK VARCHAR2(4000), 
	DEAL_TAG VARCHAR2(4000), 
	REFA VARCHAR2(4000), 
	DAT_A VARCHAR2(4000), 
	ACCA VARCHAR2(4000), 
	KVA VARCHAR2(4000), 
	NLSA VARCHAR2(4000), 
	NETA VARCHAR2(4000), 
	SA VARCHAR2(4000), 
	DETALI VARCHAR2(4000), 
	REFB VARCHAR2(4000), 
	DAT_B VARCHAR2(4000), 
	ACCB VARCHAR2(4000), 
	KVB VARCHAR2(4000), 
	NLSB VARCHAR2(4000), 
	NETB VARCHAR2(4000), 
	SB VARCHAR2(4000), 
	FDAT VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FOREX_A ***
 exec bpa.alter_policies('ERR$_FOREX_A');


COMMENT ON TABLE BARS.ERR$_FOREX_A IS 'DML Error Logging table for "FOREX_A"';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.NTIK IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.DAT IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.RNK IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.DEAL_TAG IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.REFA IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.DAT_A IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.ACCA IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.KVA IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.NLSA IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.NETA IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.SA IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.DETALI IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.REFB IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.DAT_B IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.ACCB IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.KVB IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.NLSB IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.NETB IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.SB IS '';
COMMENT ON COLUMN BARS.ERR$_FOREX_A.FDAT IS '';



PROMPT *** Create  grants  ERR$_FOREX_A ***
grant SELECT                                                                 on ERR$_FOREX_A    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_FOREX_A    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FOREX_A.sql =========*** End *** 
PROMPT ===================================================================================== 
